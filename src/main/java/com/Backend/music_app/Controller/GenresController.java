package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.GenresCreateRequest;
import com.Backend.music_app.dto.request.update.GenreUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.GenresResponse;
import com.Backend.music_app.dto.response.Item.GenresItemResponse;
import com.Backend.music_app.entity.Genres;
import com.Backend.music_app.service.GenresService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@Slf4j
@RequestMapping("/genres")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class GenresController {
    GenresService genresService;

    @PostMapping("/create")
    ApiResponse<GenresResponse> createGenres(@RequestBody @Valid GenresCreateRequest request)
    {
        return ApiResponse.<GenresResponse>builder().code(201).result(genresService.createGenres(request)).build();
    }

    @GetMapping
    ApiResponse<List<GenresResponse>> getGenres()
    {
        return ApiResponse.<List<GenresResponse>>builder().code(200).result(genresService.getAllGenres()).build();
    }

    @PutMapping("/{id}")
    ApiResponse<GenresResponse> updateGenre(@PathVariable UUID id, @RequestBody @Valid GenreUpdateRequest request)
    {
        return ApiResponse.<GenresResponse>builder().code(201).result(genresService.updateGenres(id, request)).build();
    }

    @GetMapping("/count")
    ApiResponse<Long> getGenresCount() {
        return ApiResponse.<Long>builder().code(200).result(genresService.getGenresCount()).build();
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteGenre(@PathVariable UUID id)
    {
        return ApiResponse.<String>builder().code(201).message("genre deleted").build();
    }
}
