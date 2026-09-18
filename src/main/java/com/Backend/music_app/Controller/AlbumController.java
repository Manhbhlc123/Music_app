package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.AlbumCreateRequest;
import com.Backend.music_app.dto.request.update.AlbumUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.service.AlbumService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/albums")
public class AlbumController {
    AlbumService albumService;

    @PostMapping("/create")
    ApiResponse<AlbumItemResponse> createAlbum(@RequestBody @Valid AlbumCreateRequest request)
    {
        return ApiResponse.<AlbumItemResponse>builder().code(201).result(albumService.createAlbum(request)).build();
    }

    @GetMapping
    ApiResponse<List<AlbumItemResponse>> getAlbums()
    {
        return ApiResponse.<List<AlbumItemResponse>>builder().code(200).result(albumService.getAlbums()).build();
    }

    @PutMapping("/update/{id}")
    ApiResponse<AlbumItemResponse> updateAlbum(@PathVariable UUID id, @RequestBody AlbumUpdateRequest request)
    {
        return ApiResponse.<AlbumItemResponse>builder().code(200).result(albumService.updateAlbum(id, request)).build();
    }

    @GetMapping("/{albumId}/songs")
    public ApiResponse<List<SongItemResponse>> getSongByAlbumId(@PathVariable UUID albumId) {
        return ApiResponse.<List<SongItemResponse>>builder().code(200).result(albumService.getSongOfAlbum(albumId)).build();
    }

    @PostMapping("/{albumId}/songs/{songId}")
    public ApiResponse<String> addSongToAlbum(@PathVariable UUID albumId, @PathVariable UUID songId) {
        albumService.addSongToAlbum(albumId, songId);

        return ApiResponse.<String>builder().code(200).message("Song successfully added to the album.").build();
    }

    @GetMapping("/count")
    public ApiResponse<Long> getAlbumCount()
    {
        return ApiResponse.<Long>builder().code(200).result(albumService.albumCount()).build();
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> deleteAlbum(@PathVariable UUID id)
    {
        albumService.deleteAlbum(id);
        return ApiResponse.<Void>builder().code(201).message("Album successfully deleted.").build();
    }
}
