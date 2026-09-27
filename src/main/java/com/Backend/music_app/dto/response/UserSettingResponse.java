package com.Backend.music_app.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Map;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserSettingResponse {
    UUID id;
    boolean downloadOnlyWifi;
    boolean notificationEnabled;
    Map<String, Object> equalizerPreset;
}
