package com.Backend.music_app.mapper;


import com.Backend.music_app.dto.request.BannerCreateRequest;
import com.Backend.music_app.dto.response.BannerResponse;
import com.Backend.music_app.entity.Banner;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BannerMapper{
    @Mapping(source = "isActive", target = "isActive")
    Banner toBanner(BannerCreateRequest request);

    @Mapping(source = "isActive", target = "isActive")
    BannerResponse toBannerResponse(Banner banner);
}
