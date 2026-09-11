package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.LyricLineRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.SongLyricResponse;
import com.Backend.music_app.service.SongLyricSyncService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/songs/{songId}/lyrics")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SongLyricSyncController {
    SongLyricSyncService songLyricSyncService;

    //xem lời bài hát
    @GetMapping
    public ApiResponse<SongLyricResponse> getLyrics(@PathVariable("songId") UUID songId)
    {
        SongLyricResponse response = songLyricSyncService.getLyricsBySongId(songId);

        return ApiResponse.<SongLyricResponse>builder().code(200).result(response).build();
    }

    //update lyrics
    @PostMapping
    public ApiResponse<SongLyricResponse> saveLyrics(@PathVariable UUID songId, @RequestBody List<LyricLineRequest> requests)
    {
        SongLyricResponse response = songLyricSyncService.saveOrUpdateLyrics(songId, requests);

        return ApiResponse.<SongLyricResponse>builder().code(200).message("Lưu thành công lời bài hát").result(response).build();
    }

    //delete lyrics
    @DeleteMapping
    public ApiResponse<Void> deleteLyrics(@PathVariable UUID songId)
    {
        songLyricSyncService.deleteLyrics(songId);
        return ApiResponse.<Void>builder().code(200).message("Xóa thành công lời bài hát").build();
    }
}

