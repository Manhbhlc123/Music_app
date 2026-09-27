package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.update.UserSettingUpdateRequest;
import com.Backend.music_app.dto.response.UserSettingResponse;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.entity.UserSetting;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.UserMapper;
import com.Backend.music_app.mapper.UserSettingMapper;
import com.Backend.music_app.repository.UserRepository;
import com.Backend.music_app.repository.UserSettingRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserSettingService {
    UserSettingRepository userSettingRepository;
    UserRepository userRepository;
    UserSettingMapper userSettingMapper;

    private UserSetting getOrCreateUserSettingEntity(String userName) {
        User user = userRepository.findUsersByName(userName)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        return userSettingRepository.findByUserId(user.getId()).orElseGet(() -> {
            UserSetting defaultSetting = UserSetting.builder()
                    .user(user)
                    .downloadOnlyWifi(false)
                    .notificationEnabled(true)
                    .equalizerPreset(null)
                    .build();
            return userSettingRepository.save(defaultSetting);
        });
    }

    @Transactional
    public UserSettingResponse getUserSetting(String userName) {
        UserSetting userSetting = getOrCreateUserSettingEntity(userName);

        return userSettingMapper.toUserSettingResponse(userSetting);
    }

    @Transactional
    public UserSettingResponse updateUseSetting(UserSettingUpdateRequest request, String userName) {
        UserSetting setting = getOrCreateUserSettingEntity(userName);
        userSettingMapper.updateUserSetting(setting, request);
        userSettingRepository.save(setting);
        return  userSettingMapper.toUserSettingResponse(setting);
    }



}
