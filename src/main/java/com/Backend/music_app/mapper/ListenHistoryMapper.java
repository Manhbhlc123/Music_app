package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.ListenHistoryRequest;
import com.Backend.music_app.dto.response.Item.ListenHistoryItemResponse;
import com.Backend.music_app.entity.ListenHistory;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ListenHistoryMapper {
    ListenHistory toListenHistory(ListenHistoryRequest request);

    @Mapping(source = "song.id", target = "songId")
    @Mapping(source = "song.title", target = "songTitle") // Sửa 'title' thành tên biến của bạn
    @Mapping(source = "song.artist.name", target = "artistName") // Sửa nếu cấu trúc Artist khác
    @Mapping(source = "song.coverUrl", target = "coverUrl")
    ListenHistoryItemResponse toListenHistoryResponse(ListenHistory listenHistory);

}
