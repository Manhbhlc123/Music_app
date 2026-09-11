package com.Backend.music_app.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SearchHistoryResponse {
    UUID id;
    String keyword;
    String resultType;
    UUID clickedResultId;
    LocalDateTime searchedAt;
}
