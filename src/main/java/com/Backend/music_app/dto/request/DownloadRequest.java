package com.Backend.music_app.dto.request;


import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class DownloadRequest {
    @NotNull(message = "ID bài hát không được để trống")
    UUID songId;

    @Builder.Default
    String quality = "normal";

    String fileLocalPath;

}
