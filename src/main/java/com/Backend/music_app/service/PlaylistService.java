package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.PlaylistCreateRequest;
import com.Backend.music_app.dto.response.Item.PlaylistItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.dto.response.PlaylistResponse;
import com.Backend.music_app.entity.Playlist;
import com.Backend.music_app.entity.PlaylistSong;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.PlaylistMapper;
import com.Backend.music_app.mapper.SongMapper;
import com.Backend.music_app.repository.PlaylistRepisitory;
import com.Backend.music_app.repository.PlaylistSongRepository;
import com.Backend.music_app.repository.SongRepository;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PlaylistService {
    PlaylistRepisitory playlistRepisitory;
    PlaylistSongRepository playlistSongRepository;
    SongRepository songRepository;
    UserRepository userRepository;
    PlaylistMapper playlistMapper;
    SongMapper songMapper;

    @Transactional
    public void addSongToPlaylist(UUID playlistId, UUID songId) {
        //kiểm tra có bài hát này chưa
        Playlist playlist = playlistRepisitory.findById(playlistId).orElseThrow(() -> new RuntimeException("Playlist is not existed"));

        Song song = songRepository.findById(songId).orElseThrow(() -> new RuntimeException("Song is not existed"));

        if (playlistSongRepository.existsByPlaylistIdAndSongId(playlistId, songId)) {
            throw new RuntimeException("This song is existed in playlist");
        }

        int nextOrderIndex = playlistSongRepository.findMaxOrderIndexByPlaylistId(playlistId) + 1;

        PlaylistSong newPlaylistSong = PlaylistSong.builder().playlist(playlist).song(song).orderIndex(nextOrderIndex).build();

        playlistSongRepository.save(newPlaylistSong);

    }

    @Transactional
    public void addSongToMyPlaylist(UUID playlistId, UUID songId) {
        //kiểm tra có bài hát này chưa
        Playlist playlist = playlistRepisitory.findById(playlistId).orElseThrow(() -> new RuntimeException("Playlist is not existed"));

        Song song = songRepository.findById(songId).orElseThrow(() -> new RuntimeException("Song is not existed"));

        if (!playlist.isSystem() && playlistSongRepository.existsByPlaylistIdAndSongId(playlistId, songId)) {
            throw new RuntimeException("This song is existed in playlist");
        }

        int nextOrderIndex = playlistSongRepository.findMaxOrderIndexByPlaylistId(playlistId) + 1;

        PlaylistSong newPlaylistSong = PlaylistSong.builder().playlist(playlist).song(song).orderIndex(nextOrderIndex).build();

        playlistSongRepository.save(newPlaylistSong);

    }

    @Transactional
    @PreAuthorize("hasAuthority('Role_USER')")
    public PlaylistItemResponse createPlaylistByUser(PlaylistCreateRequest request, String username) {
        if (playlistRepisitory.existsPlaylistByIsSystemAndTitle(false, request.getTitle())) {
            throw new AppException(ErrorCode.PLAYLIST_EXISTED);
        }

        User currentUser = userRepository.findUsersByName(username).orElseThrow(() -> new RuntimeException("user not found"));

        Playlist newPlaylist = playlistMapper.toPlaylist(request);

        newPlaylist.setUser(currentUser);

        Playlist savedPlaylist = playlistRepisitory.save(newPlaylist);

        return playlistMapper.toPlaylistItemResponse(savedPlaylist);
    }

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public PlaylistItemResponse createPlaylistByAdmin(PlaylistCreateRequest request) {
        if (playlistRepisitory.existsPlaylistByIsSystemAndTitle(true, request.getTitle())) {
            throw new AppException(ErrorCode.PLAYLIST_EXISTED);
        }


        Playlist newPlaylist = playlistMapper.toPlaylist(request);

        newPlaylist.setUser(null);

        newPlaylist.setSystem(true);

        Playlist savedPlaylist = playlistRepisitory.save(newPlaylist);

        return playlistMapper.toPlaylistItemResponse(savedPlaylist);
    }

    @Transactional
    public List<PlaylistItemResponse> getMyPlaylist(String userName) {
        List<Playlist> playlists = playlistRepisitory.findAllByUserNameOrderByCreatedAtAsc(userName);

        return playlists.stream().map(playlistMapper::toPlaylistItemResponse).toList();
    }

    @Transactional
    public List<PlaylistItemResponse> getPlaylistHome(){
        List<Playlist> playlists = playlistRepisitory.findAllByIsSystem(true);
        return playlists.stream().map(playlistMapper::toPlaylistItemResponse).toList();
    }

    @Transactional
    public void deletePlaylist(UUID playlistId) {
        try {
            playlistRepisitory.deletePlaylistById(playlistId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @Transactional(readOnly = true)
    public List<SongItemResponse> getSongOfPlaylist(UUID playlistId) {
        // 1. (Tuỳ chọn) Kiểm tra xem Playlist có tồn tại không
        if (!playlistRepisitory.existsById(playlistId)) {
            throw new AppException(ErrorCode.PLAYLIST_NOT_FOUND);
        }

        // 2. Lấy danh sách Bài hát (Entity) thuộc về Playlist này từ DB
        List<Song> songs = playlistSongRepository.findSongsByPlaylistId(playlistId);

        // 3. Map từ List<Song> sang List<SongItemResponse>
        return songs.stream()
                .map(songMapper::toSongItemResponse)
                .toList();
    }


    public long playlistCount()
    {
        return playlistRepisitory.count();
    }

}
