package com.Backend.music_app.dto.request.update;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ArtistUpdateRequest {
    @JsonProperty("name")
    String name;

    @JsonProperty("avatarUrl")
    String avatarUrl;

    @JsonProperty("bio")
    String bio;

    @JsonProperty("country")
    String country;

    @JsonProperty("verified")
    boolean verified;
}
