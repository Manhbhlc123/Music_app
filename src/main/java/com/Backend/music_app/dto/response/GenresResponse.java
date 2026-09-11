package com.Backend.music_app.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
public class GenresResponse {
    String name;
    String description;
    String coverUrl;

}
