package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.ArtistResponse;
import com.Backend.music_app.dto.response.FollowResponse;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.service.FollowService;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/follows")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FollowController {
    FollowService service;

    @GetMapping
    public ApiResponse<Page<ArtistItemResponse>> getFollowedArtist(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        Pageable pageable = PageRequest.of(page, size);

        return ApiResponse.<Page<ArtistItemResponse>>builder().code(200).result(service.getFollowedArtist(userName, pageable)).build();
    }

    @PostMapping("/toggle/{artistId}")
    public ApiResponse<FollowResponse> toggleFollow(@PathVariable("artistId") UUID artistId) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        boolean isFollowing = service.toggleFollow(userName, artistId);

        return ApiResponse.<FollowResponse>builder().code(200).result(FollowResponse.builder().artistId(artistId).isFollowing(isFollowing).build()).build();
    }


    @GetMapping("/state/{artistId}")
    public ApiResponse<Boolean> checkState(@PathVariable("artistId") UUID artistId)
    {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return ApiResponse.<Boolean>builder().code(200).result(service.checkState(userName, artistId)).build();
    }
}
