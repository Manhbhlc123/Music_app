package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.FavoriteStatusResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.service.FavoriteService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/favorites")
@Log4j2
public class FavoriteController {
    FavoriteService favoriteService;

    @GetMapping
    public ApiResponse<Page<SongItemResponse>> getFavoriteSongs(
            Authentication authentication,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        String userName = authentication.getName();
        Pageable pageable = PageRequest.of(page, size);

        Page<SongItemResponse> favoriteSongs = favoriteService.getFavoriteSongs(userName, pageable);

        return ApiResponse.<Page<SongItemResponse>>builder().code(200).result(favoriteSongs).build();
    }

    @PostMapping("/toggle/{songId}")
    public ApiResponse<FavoriteStatusResponse> toggleFavorite(
            Authentication authentication,
            @PathVariable UUID songId
    ) {
        String userName = authentication.getName();
        FavoriteStatusResponse response = favoriteService.toggleFavorite(userName, songId);
        return ApiResponse.<FavoriteStatusResponse>builder().code(201).result(response).build();
    }

    @GetMapping("/check/{songId}")
    public ApiResponse<Boolean> checkIsFavorite(
            Authentication authentication,
            @PathVariable UUID songId
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        boolean isFav = favoriteService.isFavorite(userId, songId);
        return ApiResponse.<Boolean>builder().code(200).result(isFav).build();
    }
}