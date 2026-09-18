package com.Backend.music_app.mapper;


import com.Backend.music_app.dto.request.GenresCreateRequest;
import com.Backend.music_app.dto.request.update.GenreUpdateRequest;
import com.Backend.music_app.dto.response.GenresResponse;
import com.Backend.music_app.dto.response.Item.GenresItemResponse;
import com.Backend.music_app.entity.Genres;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;


@Mapper(componentModel = "spring")
public interface GenresMapper{
    Genres toGenres(GenresCreateRequest request);
    GenresResponse toGenresResponse(Genres request);
    GenresItemResponse toGenresItemResponse(Genres request);
    void toUpdateGenre(@MappingTarget Genres genres, GenreUpdateRequest request);
}
