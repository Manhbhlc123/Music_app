package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.GenresCreateRequest;
import com.Backend.music_app.dto.request.update.GenreUpdateRequest;
import com.Backend.music_app.dto.response.GenresResponse;
import com.Backend.music_app.dto.response.Item.GenresItemResponse;
import com.Backend.music_app.entity.Genres;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.GenresMapper;
import com.Backend.music_app.repository.GenresRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class GenresService {

    GenresMapper genresMapper;
    GenresRepository genresRepository;

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public GenresResponse createGenres(GenresCreateRequest request) {
        // Kiểm tra xem thể loại đã tồn tại chưa
        if (genresRepository.existsGenresByName(request.getName())) {
            throw new AppException(ErrorCode.GENRES_EXISTED);
        }

        // Map từ Request DTO sang Entity
        Genres genres = genresMapper.toGenres(request);

        // Lưu vào DB và trả về Response DTO
        return genresMapper.toGenresResponse(genresRepository.save(genres));
    }

    public List<GenresResponse> getAllGenres() {
        return genresRepository.findAll()
                .stream()
                .map(genresMapper::toGenresResponse)
                .toList();
    }

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public GenresResponse updateGenres(UUID genreId, GenreUpdateRequest request) {
        Genres genre = genresRepository.findById(genreId).orElseThrow(() -> new AppException(ErrorCode.GENRES_NOT_FOUND));

        genresMapper.toUpdateGenre(genre, request);

        return genresMapper.toGenresResponse(genresRepository.save(genre));
    }

    public Long getGenresCount() {
        return genresRepository.count();
    }

    @Transactional
    public void deleteGenres(UUID genreId) {
        genresRepository.deleteById(genreId);
    }
}