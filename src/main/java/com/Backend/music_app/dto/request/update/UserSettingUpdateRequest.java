package com.Backend.music_app.dto.request.update;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.Map;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserSettingUpdateRequest {
    @JsonProperty("download_only_wifi")
    boolean downloadOnlyWifi;
    @JsonProperty("notification_enabled")
    boolean notificationEnabled;
    @JsonProperty("equalizer_preset")
    Map<String, Object> equalizerPreset;
}
