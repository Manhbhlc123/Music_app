package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.UserCreateRequest;
import com.Backend.music_app.dto.request.update.UserUpdateRequest;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User toUser(UserCreateRequest request);

    @Mapping(source = "birthYear", target = "birthday_year")
    @Mapping(source = "avatarUrl", target = "avatar_url")
    @Mapping(source = "vip", target = "is_vip")
    @Mapping(source = "vipAutoRenew", target = "vip_auto_renew")
    @Mapping(source = "vipExpiredAt", target = "vip_expired_at")
    @Mapping(source = "twoFactorEnabled", target = "two_factor_enable")
    @Mapping(source = "createdAt", target = "create_at")
    @Mapping(source = "updatedAt", target = "update_at")
    UserResponse toUserResponse(User user);
    void updateUser(@MappingTarget User user, UserUpdateRequest request);
}
