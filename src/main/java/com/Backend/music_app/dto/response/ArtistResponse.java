package com.Backend.music_app.dto.response;

import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;

import java.util.List;
import java.util.UUID;

public class ArtistResponse {
    UUID id;
    String name;
    String avatarUrl;
    String bio;
    String country;
    boolean isVerified = false;
    Long followersCount;
    List<SongItemResponse> topSongs;
    List<AlbumItemResponse> albums;

}
