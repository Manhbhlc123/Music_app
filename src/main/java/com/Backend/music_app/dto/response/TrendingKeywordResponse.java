package com.Backend.music_app.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TrendingKeywordResponse {

    UUID id;

    String keyword;

    Long searchCount;


}
