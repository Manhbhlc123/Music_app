package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.PlaylistCreateRequest;
import com.Backend.music_app.dto.response.Item.PlaylistItemResponse;
import com.Backend.music_app.entity.Playlist;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface PlaylistMapper {
    @Mapping(source = "coverUrl", target = "coverUrl")
    @Mapping(source = "public", target = "isPublic")
    Playlist toPlaylist(PlaylistCreateRequest request);

    @Mapping(source = "coverUrl", target = "coverUrl")
    @Mapping(source = "totalSong", target = "totalSong", defaultValue = "0")
    PlaylistItemResponse toPlaylistItemResponse(Playlist playlist);
}
