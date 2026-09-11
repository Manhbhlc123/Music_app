package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.SongCreateRequest;
import com.Backend.music_app.dto.request.update.SongUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.service.SongService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.log4j.Log4j2;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RestController
@RequestMapping("/songs")
@Log4j2
public class SongController {

    SongService songService;

    @PostMapping("/create")
    ApiResponse<SongItemResponse> createSong(@RequestBody @Valid SongCreateRequest request) {
        return ApiResponse.<SongItemResponse>builder().code(201).result(songService.createSong(request)).build();
    }


    @GetMapping
    ApiResponse<List<SongItemResponse>> ListSong() {
        return ApiResponse.<List<SongItemResponse>>builder().code(200).result(songService.getAllSong()).build();
    }

    @PatchMapping("/{id}")
    ApiResponse<SongItemResponse> update(@PathVariable UUID id, @RequestBody SongUpdateRequest request) {
        return ApiResponse.<SongItemResponse>builder().code(200).result(songService.updateSong(id, request)).build();
    }

    @PatchMapping("/{songId}/play")
    public ApiResponse<Void> increasePlayCount(@PathVariable UUID songId)
    {
        songService.increasePlayCount(songId);

        return ApiResponse.<Void>builder().code(200).message("play count increase").build();
    }

    @GetMapping("/artists/{artistId}")
    ApiResponse<List<SongItemResponse>> getSongsOfArtist(@PathVariable UUID artistId, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size)
    {
        Pageable pageable = PageRequest.of(page, size);

        return ApiResponse.<List<SongItemResponse>>builder().code(200).result(songService.getSongOfArtist(artistId, pageable)).build();
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteSong(@PathVariable("id") UUID id)
    {
        songService.deleteSong(id);
        return ApiResponse.<String>builder().code(201).message("delete successful").build();
    }

    @GetMapping("/count")
    public ApiResponse<Long>  songCount()
    {
        return ApiResponse.<Long>builder().code(200).result(songService.songCount()).build();
    }
}
