package com.Backend.music_app.dto.request.update;

import jakarta.persistence.Column;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PlaylistUpdateRequest {
    String title;
    String coverUrl;
    Boolean isPublic;
}
