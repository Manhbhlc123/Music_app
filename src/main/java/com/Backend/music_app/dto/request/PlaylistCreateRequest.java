package com.Backend.music_app.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PlaylistCreateRequest {
    String title;
    @JsonProperty("isPublic")
    boolean isPublic;
    @JsonProperty("coverUrl")
    String coverUrl;
    @JsonProperty("isSystem")
    boolean isSystem;;

}
