package com.Backend.music_app.dto.request;
import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ArtistCreateRequest {
    String name;
    String avatarUrl;
    String bio;
    String country;
    List<SongItemResponse> topSongs;
    List<AlbumItemResponse> albums;
}
