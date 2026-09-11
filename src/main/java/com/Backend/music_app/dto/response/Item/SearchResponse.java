package com.Backend.music_app.dto.response.Item;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SearchResponse {
    List<SongItemResponse> songs;

    List<ArtistItemResponse> artists;

    List<AlbumItemResponse> albums;

    List<PlaylistItemResponse> playlists;

}
