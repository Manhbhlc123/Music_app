package com.Backend.music_app.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.UUID;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AlbumCreateRequest {

    @NotBlank(message = "Tên album không được để trống")
    String title;

    @NotNull(message = "ID ca sĩ không được để trống")
    UUID artistId;

    String coverUrl;

    LocalDate releaseDate;

    String description;
}