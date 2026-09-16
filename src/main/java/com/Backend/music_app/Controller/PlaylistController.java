package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.PlaylistCreateRequest;
import com.Backend.music_app.dto.request.update.PlaylistUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.Item.PlaylistItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.service.PlaylistService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/playlists")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PlaylistController {
    PlaylistService playlistService;

    @PostMapping("/createByUser")
    public ApiResponse<PlaylistItemResponse> createPlaylistByUser(@RequestBody @Valid PlaylistCreateRequest request) {

        String currentUserName = SecurityContextHolder.getContext().getAuthentication().getName();
        PlaylistItemResponse response = playlistService.createPlaylistByUser(request, currentUserName);
        return ApiResponse.<PlaylistItemResponse>builder().code(HttpStatus.CREATED.value()).result(response).build();
    }

    @PostMapping("/createByAdmin")
    public ApiResponse<PlaylistItemResponse> createPlaylistByAdmin(@RequestBody @Valid PlaylistCreateRequest request) {

        PlaylistItemResponse response = playlistService.createPlaylistByAdmin(request);
        return ApiResponse.<PlaylistItemResponse>builder().code(HttpStatus.CREATED.value()).result(response).build();
    }

    @GetMapping("/getMyPlaylist")
    public ApiResponse<List<PlaylistItemResponse>> getMyPlaylist() {

        String currentUserName = SecurityContextHolder.getContext().getAuthentication().getName();
        List<PlaylistItemResponse> responses = playlistService.getMyPlaylist(currentUserName);
        return ApiResponse.<List<PlaylistItemResponse>>builder().code(200).result(responses).build();
    }

    @PostMapping("/{playlistId}/songs/{songId}")
    public ApiResponse<String> addSongToPlaylist(@PathVariable UUID playlistId, @PathVariable UUID songId) {
        playlistService.addSongToPlaylist(playlistId, songId);

        return ApiResponse.<String>builder().code(200).message("Song successfully added to the playlist.").build();
    }

    @PostMapping("/my/{playlistId}/songs/{songId}")
    public ApiResponse<String> addSongToMyPlaylist(@PathVariable UUID playlistId, @PathVariable UUID songId) {
        playlistService.addSongToMyPlaylist(playlistId, songId);

        return ApiResponse.<String>builder().code(200).message("Song successfully added to the my playlist.").build();
    }
    @GetMapping("/getPlaylistHome")
    public ApiResponse<List<PlaylistItemResponse>> getPlaylistHome() {
        return ApiResponse.<List<PlaylistItemResponse>>builder().code(200).result(playlistService.getPlaylistHome()).build();
    }

    @DeleteMapping("/{id}")
    public ApiResponse<String> deletePlaylistByTitle(@PathVariable UUID id) {
        playlistService.deletePlaylist(id);

        return ApiResponse.<String>builder().code(200).message("delete complete").build();
    }

    @GetMapping("/{id}/songs")
    public ApiResponse<List<SongItemResponse>> getSongByPlaylistId(@PathVariable UUID id) {
        return ApiResponse.<List<SongItemResponse>>builder().code(200).result(playlistService.getSongOfPlaylist(id)).build();
    }

    @GetMapping("/count")
    public ApiResponse<Long> count() {
        return ApiResponse.<Long>builder().code(200).result(playlistService.playlistCount()).build();
    }

    @GetMapping
    public ApiResponse<List<PlaylistItemResponse>> getAllPlaylists() {
        return ApiResponse.<List<PlaylistItemResponse>>builder().code(200).result(playlistService.getAllPlaylist()).build();
    }

    @PutMapping("/{id}")
    public ApiResponse<PlaylistItemResponse> updatePlaylist(@RequestBody @Valid PlaylistUpdateRequest request, @PathVariable UUID id) {
        return ApiResponse.<PlaylistItemResponse>builder().code(201).result(playlistService.updatePlaylist(id, request)).build();
    }
}
