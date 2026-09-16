package com.Backend.music_app.dto.response.Item;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PlaylistItemResponse {
    UUID id;
    String title;
    String coverUrl;
    Integer totalSong;
    Boolean isPublic;
}
