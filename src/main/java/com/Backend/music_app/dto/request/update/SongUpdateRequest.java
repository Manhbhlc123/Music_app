package com.Backend.music_app.dto.request.update;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SongUpdateRequest {

    @Size(max = 200, message = "TITLE_TOO_LONG")
    @JsonProperty("title")
    String title;

    @JsonProperty("artistId")
    UUID artistId;

    @JsonProperty("album_id")
    UUID albumId;

    @JsonProperty("genre_id")
    UUID genreId;

    @Min(value = 0, message = "DURATION_MUST_BE_POSITIVE")
    @JsonProperty("duration")
    Integer duration; // Dùng Integer để chấp nhận null khi không cập nhật

    @JsonProperty("audioUrlNormal")
    String audioUrlNormal;

    @JsonProperty("audioUrlHq")
    String audioUrlHq;

    @JsonProperty("coverUrl")
    String coverUrl;

    @JsonProperty("lyricsPlain")
    String lyricsPlain;

    @JsonProperty("releaseDate")
    LocalDate releaseDate;

    @JsonProperty("isActive")
    Boolean isActive; // Dùng Boolean (object) thay vì boolean (primitive) để tránh bị gán mặc định false khi null

    @JsonProperty("searchKeywords")
    String searchKeywords;
}