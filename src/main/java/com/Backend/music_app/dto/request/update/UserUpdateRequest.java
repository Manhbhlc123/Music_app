package com.Backend.music_app.dto.request.update;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
//class yêu cầu dữ liệu khi muốn update user
public class UserUpdateRequest {
    String name;
    String email;
    String phone;
    @JsonProperty("birthday_year")
    int birthYear;
    String country;
    String avatarUrl;
//    String theme_color;
    String language;
    String role;
    boolean isVip;
    boolean vipAutoRenew;
    Date vipExpiredAt;
    boolean twoFactorEnabled;
    String status;
    Date updatedAt;
}
