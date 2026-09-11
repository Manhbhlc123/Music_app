package com.Backend.music_app.mapper;


import com.Backend.music_app.dto.response.TrendingKeywordResponse;
import com.Backend.music_app.entity.TrendingKeyword;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface TrendingKeywordMapper {

    TrendingKeywordResponse toResponse(TrendingKeyword trendingKeyword);
}
