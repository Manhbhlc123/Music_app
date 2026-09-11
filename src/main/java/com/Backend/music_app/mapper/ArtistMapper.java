package com.Backend.music_app.mapper;


import com.Backend.music_app.dto.request.ArtistCreateRequest;
import com.Backend.music_app.dto.request.update.ArtistUpdateRequest;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.dto.response.ArtistResponse;
import com.Backend.music_app.entity.Artist;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;


@Mapper(componentModel = "spring")
public interface ArtistMapper {
    Artist toArtist(ArtistCreateRequest request);
    ArtistResponse toArtistResponse(Artist request);
    ArtistItemResponse toArtistItemResponse(Artist request);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void toUpdateArtist(@MappingTarget Artist artist, ArtistUpdateRequest request);
}
