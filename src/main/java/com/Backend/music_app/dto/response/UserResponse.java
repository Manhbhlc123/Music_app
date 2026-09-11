package com.Backend.music_app.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    UUID id;
    String name;
    String email;
    String phone;
    int birthday_year;
    String country;
    String avatar_url;
    String theme_color;
    String language;
    String role;
    boolean is_vip;
    boolean vip_auto_renew;
    Date vip_expired_at;
    boolean two_factor_enable;
    String status;
    Date create_at;
    Date update_at;
}
