package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.BannerCreateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.BannerResponse;
import com.Backend.music_app.service.BannerService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/banners")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BannerController {
    final BannerService bannerService;

    @PostMapping("/create")
    public ApiResponse<BannerResponse> createBanner(@RequestBody @Valid BannerCreateRequest request) {
        return ApiResponse.<BannerResponse>builder().code(HttpStatus.CREATED.value()).result(bannerService.createBanner(request)).build();
    }

    @GetMapping("/getAllBanner")
    public ApiResponse<List<BannerResponse>> getAllBanner() {
        return ApiResponse.<List<BannerResponse>>builder().code(200).result(bannerService.getALLBanner()).build();
    }

    @DeleteMapping("/delete/{id}")
    public ApiResponse<String> deleteBanner(@PathVariable UUID id)
    {
        bannerService.deleteBanner(id);
        return ApiResponse.<String>builder().code(200).message("delete completed").build();
    }
}
