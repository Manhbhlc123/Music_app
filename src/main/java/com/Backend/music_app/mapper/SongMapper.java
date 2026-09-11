package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.SongCreateRequest;
import com.Backend.music_app.dto.request.update.SongUpdateRequest;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Song;
import org.mapstruct.*;

@Mapper(componentModel = "Spring")
public interface SongMapper {
    Song toSong(SongCreateRequest request);
//    void updateUser(@MappingTarget User user, UserUpdateRequest request);
    @Mapping(source = "artist.name", target = "artistName")
    @Mapping(source = "artist.id", target = "artistId")
    @Mapping(source = "playCount", target = "playCount", defaultValue = "0L")
    SongItemResponse toSongItemResponse(Song song);


    void updateSongFromDto(SongUpdateRequest dto, @MappingTarget Song entity);
}
