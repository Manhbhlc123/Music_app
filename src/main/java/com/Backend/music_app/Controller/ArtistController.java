package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.ArtistCreateRequest;
import com.Backend.music_app.dto.request.update.ArtistUpdateRequest;
import com.Backend.music_app.dto.request.update.UserUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.ArtistResponse;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.entity.Artist;
import com.Backend.music_app.service.ArtistService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.rmi.server.UID;
import java.util.List;
import java.util.UUID;

@RestController
@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/artists")
@Log4j2
public class ArtistController {
    ArtistService artistService;

    @PostMapping("/create")
    ApiResponse<ArtistItemResponse> createArtist(@RequestBody @Valid ArtistCreateRequest request) {
        return ApiResponse.<ArtistItemResponse>builder().code(201).result(artistService.createArtist(request)).build();
    }

    @GetMapping
    ApiResponse<List<ArtistItemResponse>> getArtist() {
        return ApiResponse.<List<ArtistItemResponse>>builder().code(200).result(artistService.getArtists()).build();
    }

    @GetMapping("/{artistId}")
    ApiResponse<ArtistItemResponse> getArtist(@PathVariable("artistId") UUID artistId)
    {
        return ApiResponse.<ArtistItemResponse>builder().code(200).result(artistService.getArtistById(artistId)).build();
    }

    @PutMapping("/update/{artistId}")
    ApiResponse<ArtistItemResponse> updateUser(@PathVariable UUID artistId, @RequestBody ArtistUpdateRequest request) {
        return ApiResponse.<ArtistItemResponse>builder().code(200).result(artistService.updateArtist(artistId, request)).build();
    }

}
