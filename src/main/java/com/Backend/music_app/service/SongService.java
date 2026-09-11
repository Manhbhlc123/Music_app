package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.SongCreateRequest;
import com.Backend.music_app.dto.request.update.SongUpdateRequest;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Album;
import com.Backend.music_app.entity.Artist;
import com.Backend.music_app.entity.Genres;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.SongMapper;
import com.Backend.music_app.repository.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SongService {

    SongRepository songRepository;
    ArtistRepository artistRepository;
    AlbumRepositoty albumRepository;
    GenresRepository genresRepository;
    SongMapper songMapper;

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public SongItemResponse createSong(SongCreateRequest request) {
        // 1. Kiểm tra bài hát đã tồn tại chưa (tuỳ logic, có thể check cả title + artistId)
        if (songRepository.existsSongByTitle(request.getTitle())) {
            throw new AppException(ErrorCode.SONG_EXISTED);
        }

        // 2. Tìm kiếm các Entity liên quan từ Database
        Artist artist = artistRepository.findById(request.getArtistId())
                .orElseThrow(() -> new AppException(ErrorCode.ARTIST_NOT_FOUND));

        Genres genre = genresRepository.findById(request.getGenreId())
                .orElseThrow(() -> new AppException(ErrorCode.GENRES_NOT_FOUND));

        Album album = null;
        if (request.getAlbumId() != null) {
            album = albumRepository.findById(request.getAlbumId())
                    .orElseThrow(() -> new AppException(ErrorCode.ALBUM_NOT_FOUND));
        }

        // 3. Map các trường cơ bản từ Request (title, duration, audioUrl,...)
        Song song = songMapper.toSong(request);

        // 4. Lắp ráp các Entity đã tìm được vào Song
        song.setArtist(artist);
        song.setGenre(genre);
        song.setAlbum(album); // Có thể null nếu là bài hát Single

        // 5. Tự động sinh từ khóa tìm kiếm (Ví dụ: "muon roi ma sao con son tung m-tp")
        String keyword = request.getTitle() + " " + artist.getName();
        song.setSearchKeywords(keyword.toLowerCase());

        song.setPlayCount(0L);

        // 6. Lưu xuống DB và trả về
        return songMapper.toSongItemResponse(songRepository.save(song));
    }

//    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public List<SongItemResponse> getAllSong()
    {
        return songRepository.findAll().stream().map(songMapper::toSongItemResponse).toList();
    }


    @Transactional
    public SongItemResponse updateSong(UUID songId, SongUpdateRequest request) {
        // 1. Kiểm tra tồn tại của bài hát
        Song song = songRepository.findById(songId)
                .orElseThrow(() -> new RuntimeException("Song not found with id: " + songId));

        // 2. Cập nhật các trường văn bản và dữ liệu cơ bản nếu không null
        if (request.getTitle() != null) {
            song.setTitle(request.getTitle());
        }

        if (request.getDuration() != null) {
            song.setDuration(request.getDuration());
        }

        if (request.getAudioUrlNormal() != null) {
            song.setAudioUrlNormal(request.getAudioUrlNormal());
        }

        if (request.getAudioUrlHq() != null) {
            song.setAudioUrlHq(request.getAudioUrlHq());
        }

        if (request.getCoverUrl() != null) {
            song.setCoverUrl(request.getCoverUrl());
        }

        if (request.getLyricsPlain() != null) {
            song.setLyricsPlain(request.getLyricsPlain());
        }

        if (request.getReleaseDate() != null) {
            song.setReleaseDate(request.getReleaseDate());
        }

        if (request.getIsActive() != null) {
            song.setActive(request.getIsActive());
        }

        if (request.getSearchKeywords() != null) {
            song.setSearchKeywords(request.getSearchKeywords());
        }

        // 3. Cập nhật khóa ngoại Artist (Khóa ngoại chính, bắt buộc tồn tại nếu được gửi lên)
        if (request.getArtistId() != null) {
            Artist artist = artistRepository.findById(request.getArtistId())
                    .orElseThrow(() -> new RuntimeException("Artist not found with id: " + request.getArtistId()));
            song.setArtist(artist);
        }

        // 4. Cập nhật khóa ngoại Album (Có thể nhận UUID mới để gán Album)
        if (request.getAlbumId() != null) {
            Album album = albumRepository.findById(request.getAlbumId())
                    .orElseThrow(() -> new RuntimeException("Album not found with id: " + request.getAlbumId()));
            song.setAlbum(album);
        }

        // 5. Cập nhật khóa ngoại Genre (Có thể nhận UUID mới để gán Thể loại)
        if (request.getGenreId() != null) {
            Genres genre = genresRepository.findById(request.getGenreId())
                    .orElseThrow(() -> new RuntimeException("Genre not found with id: " + request.getGenreId()));
            song.setGenre(genre);
        }

        // 6. Lưu thay đổi và trả về DTO Response
        Song updatedSong = songRepository.save(song);
        return songMapper.toSongItemResponse(updatedSong);
    }


    @Transactional
    public void increasePlayCount(UUID songId)
    {
        songRepository.increasePlayCount(songId);
    }


    @Transactional(readOnly = true)
    public List<SongItemResponse> getSongOfArtist(UUID artistId, Pageable pageable)
    {
        List<Song> songsOfArtist = songRepository.findTopSongsByArtist(artistId, pageable);

        return songsOfArtist.stream().map(songMapper::toSongItemResponse).toList();
    }


    @Transactional
    public void deleteSong(UUID songId){
        try{
            songRepository.deleteById(songId);
        }catch (Exception e)
        {
            throw new RuntimeException(e);
        }
    }

    public long songCount()
    {
        return songRepository.count();
    }
}