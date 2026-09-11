package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.ListenHistoryRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.Item.ListenHistoryItemResponse;
import com.Backend.music_app.service.ListenHistoryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@Slf4j
@RequestMapping("/listenHistory")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ListenHistoryController {
    ListenHistoryService listenHistoryService;

    @GetMapping
    public ApiResponse<List<ListenHistoryItemResponse>> getHistorySong()
    {
        return ApiResponse.<List<ListenHistoryItemResponse>>builder().code(200).result(listenHistoryService.getList()).build();
    }

    @PostMapping
    public ApiResponse<ListenHistoryItemResponse> addListenHistory(@RequestBody ListenHistoryRequest request)
    {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return ApiResponse.<ListenHistoryItemResponse>builder().code(201).result(listenHistoryService.createListenHistory(userName, request)).build();
    }

    @DeleteMapping("/{id}")
    public ApiResponse<String> deleteListenHistory(@PathVariable("id") UUID id)
    {
        listenHistoryService.deleteSongOfHistoryListen(id);
        return ApiResponse.<String>builder().code(201).message("delete song in History listen successful").build();
    }

}
