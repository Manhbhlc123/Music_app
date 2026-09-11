package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.response.SearchHistoryResponse;
import com.Backend.music_app.entity.SearchHistory;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface SearchHistoryMapper {
    SearchHistoryResponse toSearchHistoryRespose(SearchHistory searchHistory);

//    SearchHistory toSearchHistory(SearchHistoryCreateRequest request);
}
