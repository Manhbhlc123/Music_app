package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.SearchHistoryCreateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.Item.SearchResponse;
import com.Backend.music_app.dto.response.SearchHistoryResponse;
import com.Backend.music_app.dto.response.TrendingKeywordResponse;
import com.Backend.music_app.entity.SearchHistory;
import com.Backend.music_app.service.SearchHistoryService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/search")
@RequiredArgsConstructor
public class SearchController {

    private final SearchHistoryService searchService;

    @GetMapping("/history")
    public ApiResponse<List<SearchHistoryResponse>> getHistory() {

        String username = SecurityContextHolder.getContext()
                .getAuthentication()
                .getName();

        return ApiResponse.<List<SearchHistoryResponse>>builder()
                .code(200)
                .result(searchService.getHistory(username))
                .build();
    }


    @GetMapping
    public ApiResponse<SearchResponse> search(
            @RequestParam @NotBlank(message = "Keyword must not be empty") String keyword,
            @RequestParam(defaultValue = "ALL") String type, // ALL, SONG, ARTIST, ALBUM
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        // Lấy username an toàn (tránh lỗi nếu user là khách chưa đăng nhập)
        String username = getSafeUsername();

        SearchResponse result = searchService.search(keyword.trim(), username, page, size);

        return ApiResponse.<SearchResponse>builder()
                .code(200)
                .result(result)
                .build();
    }

    private String getSafeUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            return auth.getName();
        }
        return null; // Người dùng chưa đăng nhập
    }

    @GetMapping("/trending")
    public ApiResponse<List<TrendingKeywordResponse>> getTrending() {
        return ApiResponse.<List<TrendingKeywordResponse>>builder().code(200).result(searchService.getTrending()).build();
    }


    @DeleteMapping("/history")
    public ApiResponse<String> clearHistory() {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        searchService.clearHistory(userName);

        return ApiResponse.<String>builder().code(200).message("complete").build();
    }

    @PostMapping("/create")
    public ApiResponse<SearchHistoryResponse> createSearchHistory(@RequestBody @Valid SearchHistoryCreateRequest request) {

        String id = SecurityContextHolder.getContext().getAuthentication().getName();
        return ApiResponse.<SearchHistoryResponse>builder().code(201).result(searchService.create(id, request)).build();
    }

}