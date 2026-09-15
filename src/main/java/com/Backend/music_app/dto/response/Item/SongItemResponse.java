package com.Backend.music_app.dto.response.Item;

import com.Backend.music_app.entity.Artist;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SongItemResponse {
    UUID id;
    String title;
    String audioUrlNormal;
    String audioUrlHq;
    int duration;
    String coverUrl;
    String lyricsPlain;
    UUID artistId;
    String artistName;
    Long playCount;
    UUID albumId;
    UUID genreId;

}

