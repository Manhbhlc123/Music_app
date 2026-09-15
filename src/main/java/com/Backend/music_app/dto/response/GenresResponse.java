package com.Backend.music_app.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
public class GenresResponse {
    @JsonProperty()
    UUID id;
    String name;
    String description;
    String coverUrl;

}
