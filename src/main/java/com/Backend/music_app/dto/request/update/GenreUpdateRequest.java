package com.Backend.music_app.dto.request.update;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class GenreUpdateRequest {
    String name;
    String coverUrl;
    String description;
}
