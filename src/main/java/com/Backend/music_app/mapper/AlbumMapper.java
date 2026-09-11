package com.Backend.music_app.mapper;


import com.Backend.music_app.dto.request.AlbumCreateRequest;
import com.Backend.music_app.dto.request.update.AlbumUpdateRequest;
import com.Backend.music_app.dto.response.Item.AlbumItemResponse;
import com.Backend.music_app.entity.Album;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface AlbumMapper {
    Album toAlbum(AlbumCreateRequest request);
    AlbumItemResponse toAlbumItemResponse(Album album);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void toUpdateAlbum(@MappingTarget Album album, AlbumUpdateRequest request);
}
