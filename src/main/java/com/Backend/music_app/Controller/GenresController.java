package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.GenresCreateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.GenresResponse;
import com.Backend.music_app.dto.response.Item.GenresItemResponse;
import com.Backend.music_app.service.GenresService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequestMapping("/genres")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class GenresController {
    GenresService genresService;

    @PostMapping("/create")
    ApiResponse<GenresItemResponse> createGenres(@RequestBody @Valid GenresCreateRequest request)
    {
        return ApiResponse.<GenresItemResponse>builder().code(201).result(genresService.createGenres(request)).build();
    }

    @GetMapping
    ApiResponse<List<GenresItemResponse>> getGenres()
    {
        return ApiResponse.<List<GenresItemResponse>>builder().code(200).result(genresService.getAllGenres()).build();
    }
}
