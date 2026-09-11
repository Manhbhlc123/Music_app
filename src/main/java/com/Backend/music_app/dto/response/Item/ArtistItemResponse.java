package com.Backend.music_app.dto.response.Item;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ArtistItemResponse {
    UUID id;
    String name;
    String avatarUrl;
    String bio;
    String country;
    boolean isVerified = false;
    @Builder.Default
    List<SongItemResponse> topSongs = new ArrayList<>();
    @Builder.Default
    List<AlbumItemResponse> albums = new ArrayList<>();
    Long followerCount;
}
