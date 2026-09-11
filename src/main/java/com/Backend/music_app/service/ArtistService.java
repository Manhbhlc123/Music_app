package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.ArtistCreateRequest;
import com.Backend.music_app.dto.request.update.ArtistUpdateRequest;
import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Album;
import com.Backend.music_app.entity.Artist;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.AlbumMapper;
import com.Backend.music_app.mapper.ArtistMapper;
import com.Backend.music_app.mapper.SongMapper;
import com.Backend.music_app.repository.AlbumRepositoty;
import com.Backend.music_app.repository.ArtistRepository;
import com.Backend.music_app.repository.SongRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ArtistService {
    SongRepository songRepository;
    SongMapper songMapper;
    AlbumRepositoty albumRepositoty;
    AlbumMapper albumMapper;

    ArtistMapper artistMapper;
    ArtistRepository artistRepository;

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public ArtistItemResponse createArtist(ArtistCreateRequest request) {
        // 1. Sửa lại hàm kiểm tra tồn tại của Artist
        if (artistRepository.existsByName((request.getName()))) {
            throw new AppException(ErrorCode.ARTIST_EXISTED);
        }

        // 2. Map dữ liệu từ Request
        Artist artist = artistMapper.toArtist(request);

        // 3. (Tuỳ chọn) Tạo keyword tìm kiếm tự động, chuyển tên thành chữ thường
        if (request.getName() != null) {
            artist.setSearchKeywords(request.getName().toLowerCase());
        }

        // 4. Lưu và trả về
        return artistMapper.toArtistItemResponse(artistRepository.save(artist));
    }

    // Đổi tên hàm thành số nhiều (getArtists)
    public List<ArtistItemResponse> getArtists() {

        return artistRepository.findAll()
                .stream()
                .map(artistMapper::toArtistItemResponse)
                .toList();
    }

    @Transactional
    public ArtistItemResponse updateArtist(UUID artistId, ArtistUpdateRequest request)
    {
        Artist artist = artistRepository.findById(artistId).orElseThrow((
                () -> new AppException(ErrorCode.ARTIST_NOT_FOUND)
        ));

        artistMapper.toUpdateArtist(artist, request);

        return artistMapper.toArtistItemResponse(artistRepository.save(artist));
    }

    @Transactional(readOnly = true)
    public ArtistItemResponse getArtistById(UUID artistId) {
        Artist artist = artistRepository.findById(artistId).orElseThrow(
                () -> new AppException(ErrorCode.ARTIST_NOT_FOUND)
        );

        // 2. Lấy Top 5 bài hát của Artist này
        Pageable Top10 = PageRequest.of(0, 10);
        List<Song> topSongs = songRepository.findTopSongsByArtist(artistId, Top10);

        List<Album> albums = albumRepositoty.findAlbumsByArtistId(artistId, Top10);

        // 3. Map Artist sang Response
        ArtistItemResponse response = artistMapper.toArtistItemResponse(artist);

        // 4. Map danh sách Song sang DTO và gán vào Response
        // Nếu bạn đã có SongMapper:
         List<SongItemResponse> topSongResponses = topSongs.stream()
                 .map(songMapper::toSongItemResponse)
                 .toList();
         response.setTopSongs(topSongResponses);

         List<AlbumItemResponse> albumList = albums.stream().map(albumMapper::toAlbumItemResponse).toList();
         response.setAlbums(albumList);
        return response;
    }

}