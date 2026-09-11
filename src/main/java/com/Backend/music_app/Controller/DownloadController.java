package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.DownloadRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.DownloadResponse;
import com.Backend.music_app.entity.Download;
import com.Backend.music_app.service.DownloadService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/downloads")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DownloadController {

    DownloadService downloadService;

    @PostMapping
    public ApiResponse<DownloadResponse> downloadSong(Authentication authentication, @RequestBody @Valid DownloadRequest request)
    {
        String userName = authentication.getName();

        DownloadResponse downloadResponse = downloadService.processDownload(userName, request);

        return ApiResponse.<DownloadResponse>builder().code(201).result(downloadResponse).build();
    }

    @GetMapping
    public ApiResponse<org.springframework.data.domain.Page<DownloadResponse>> getDownloadHistory(Authentication authentication, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size)
    {
        String userName = authentication.getName();

        Pageable pageable = PageRequest.of(page, size);

        org.springframework.data.domain.Page<DownloadResponse> history = downloadService.getUserDownloadHistory(userName, pageable);
        return ApiResponse.<Page<DownloadResponse>>builder().code(200).result(history).build();
    }

    @GetMapping("/remainingDownloadThisMonth")
    public ApiResponse<Long> getDownloadCount()
    {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return ApiResponse.<Long>builder().code(200).result(downloadService.getDownloadCount(userName)).build();
    }

}
