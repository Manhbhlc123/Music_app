package com.Backend.music_app.dto.response.Item;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ListenHistoryItemResponse {
    UUID id;

    //thông tin bài hát gộp kèm
    UUID songId;
    String songTitle;
    String artistName;
    String coverUrl;

    //thông tin lượt nghe
    Integer playDuration;
    String source;
    LocalDateTime playedAt;

}
