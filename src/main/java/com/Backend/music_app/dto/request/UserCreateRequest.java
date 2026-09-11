package com.Backend.music_app.dto.request;

import com.Backend.music_app.validator.DobConstraint;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
//Class yêu cầu dữ liệu khi muốn tạo new user
public class UserCreateRequest {
    @Size(min = 8, message = "USERNAME_INVALID")
    String name;
    @Email(message = "INVALID_EMAIL")
    String email;
    @Size(min = 6, message = "INVALID_PASSWORD")
    String password_has;
    String phone;
    @DobConstraint(min = 18, message = "INVALID_DOB")
    Integer birthday_year;
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
