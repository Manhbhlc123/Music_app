package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.update.UserSettingUpdateRequest;
import com.Backend.music_app.dto.response.UserSettingResponse;
import com.Backend.music_app.entity.UserSetting;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserSettingMapper {
    UserSettingResponse toUserSettingResponse(UserSetting userSetting);

    UserSetting toUserSetting(UserSettingResponse userSettingResponse);

    @Mapping(target = "user", ignore = true)
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "downloadOnlyWifi", source = "downloadOnlyWifi")
    @Mapping(target = "notificationEnabled", source = "notificationEnabled")
    @Mapping(target = "equalizerPreset", source = "equalizerPreset")
    void updateUserSetting(@MappingTarget UserSetting userSetting, UserSettingUpdateRequest userSettingUpdateRequest);
}
