package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.request.update.UserSettingUpdateRequest;
import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.response.UserSettingResponse;
import com.Backend.music_app.service.UserSettingService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/userSetting")
public class UserSettingController {
    UserSettingService userSettingService;

    @GetMapping
    public ApiResponse<UserSettingResponse> getUserSetting() {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return ApiResponse.<UserSettingResponse>builder().result(userSettingService.getUserSetting(userName)).build();
    }


    @PutMapping()
    public ApiResponse<UserSettingResponse> updateUserSetting(@RequestBody UserSettingUpdateRequest request) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return ApiResponse.<UserSettingResponse>builder().code(201).message("completely update download only wifi").result(userSettingService.updateUseSetting(request, userName)).build();
    }

}
