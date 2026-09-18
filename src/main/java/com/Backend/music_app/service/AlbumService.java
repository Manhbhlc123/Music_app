package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.AlbumCreateRequest;
import com.Backend.music_app.dto.request.update.AlbumUpdateRequest;
import com.Backend.music_app.dto.request.update.ArtistUpdateRequest;
import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.*;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.AlbumMapper;
import com.Backend.music_app.mapper.SongMapper;
import com.Backend.music_app.repository.AlbumRepositoty;
import com.Backend.music_app.repository.AlbumSongRepository;
import com.Backend.music_app.repository.ArtistRepository;
import com.Backend.music_app.repository.SongRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AlbumService {

    AlbumRepositoty albumRepository;
    ArtistRepository artistRepository; // Thêm repo để lấy thông tin Ca sĩ
    AlbumMapper albumMapper;
    AlbumSongRepository albumSongRepository;
    SongMapper songMapper;
    private final SongRepository songRepository;

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public AlbumItemResponse createAlbum(AlbumCreateRequest request) {
        // 1. Kiểm tra trùng tên Album (có thể kết hợp check thêm ID ca sĩ nếu cần)
        if (albumRepository.existsAlbumsByTitle(request.getTitle())) {
            throw new AppException(ErrorCode.ALBUM_EXISTED);
        }

        // 2. Tìm Artist từ DB
        Artist artist = artistRepository.findArtistById(request.getArtistId());

        // 3. Dùng mapper để map các trường cơ bản (title, coverUrl, releaseDate, description)
        Album album = albumMapper.toAlbum(request);

        // 4. Set object Artist đã tìm được vào Album
        album.setArtist(artist);

        // 5. (Tuỳ chọn) Tạo keyword tìm kiếm tự động
        album.setSearchKeywords((request.getTitle() + " " + artist.getName()).toLowerCase());

        // 6. Lưu và trả về Response
        return albumMapper.toAlbumItemResponse(albumRepository.save(album));
    }

    public List<AlbumItemResponse> getAlbums() {
        return albumRepository.findAll()
                .stream()
                .map(albumMapper::toAlbumItemResponse)
                .toList();
    }

    @PreAuthorize("hasAuthority('Role_ADMIN')")
    @Transactional
    public AlbumItemResponse updateAlbum(UUID albumId, AlbumUpdateRequest request)
    {
        Album album = albumRepository.findById(albumId).orElseThrow((
                () -> new AppException(ErrorCode.ARTIST_NOT_FOUND)
        ));

        albumMapper.toUpdateAlbum(album, request);

        return albumMapper.toAlbumItemResponse(albumRepository.save(album));
    }


    @Transactional(readOnly = true)
    public List<SongItemResponse> getSongOfAlbum(UUID albumId) {
        // 1. (Tuỳ chọn) Kiểm tra xem album có tồn tại không
        if (!albumRepository.existsById(albumId)) {
            throw new AppException(ErrorCode.ALBUM_NOT_FOUND);
        }

        // 2. Lấy danh sách Bài hát (Entity) thuộc về album này từ DB
        List<Song> songs = albumSongRepository.findSongsByAlbumId(albumId);

        // 3. Map từ List<Song> sang List<SongItemResponse>
        return songs.stream()
                .map(songMapper::toSongItemResponse)
                .toList();
    }

    @Transactional
    public void addSongToAlbum(UUID albumId, UUID songId) {
        //kiểm tra có bài hát này chưa
        Album album = albumRepository.findById(albumId).orElseThrow(() -> new AppException(ErrorCode.ALBUM_NOT_FOUND));


        Song song = songRepository.findById(songId).orElseThrow(() -> new RuntimeException("Song is not existed"));

        if (albumSongRepository.existsByAlbumIdAndSongId(albumId, songId)) {
            throw new RuntimeException("This song is existed in playlist");
        }

        int nextOrderIndex = albumSongRepository.findMaxOrderIndexByAlbumId(albumId) + 1;

        AlbumSong newAlbumSong = AlbumSong.builder().album(album).song(song).orderIndex(nextOrderIndex).build();

        albumSongRepository.save(newAlbumSong);

    }

    public long albumCount() {
        return albumRepository.count();
    }

    @Transactional
    public void deleteAlbum(UUID albumId) {
        if (!albumRepository.existsById(albumId)) {
            throw new AppException(ErrorCode.ALBUM_NOT_FOUND);
        }
        albumRepository.deleteById(albumId);
    }

}