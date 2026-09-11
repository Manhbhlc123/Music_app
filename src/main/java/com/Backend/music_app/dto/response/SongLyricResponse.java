package com.Backend.music_app.dto.response;

import com.Backend.music_app.dto.request.LyricLineRequest;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SongLyricResponse {
    UUID songId;
    List<LyricLineRequest> lyrics;
}
