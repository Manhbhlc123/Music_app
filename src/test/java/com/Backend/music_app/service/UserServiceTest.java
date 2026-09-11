package com.Backend.music_app.service;


import com.Backend.music_app.dto.request.UserCreateRequest;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.repository.UserRepository;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;

@SpringBootTest
public class UserServiceTest {
    @Autowired
    private UserService userService;

    @MockitoBean
    private UserRepository userRepository;

    private UserCreateRequest request;
    private UserResponse userResponse;
    private User user;


    @BeforeEach
    void initData() {
        LocalDateTime expiry = Instant.now().plus(29, ChronoUnit.DAYS).atZone(ZoneId.systemDefault()).toLocalDateTime();
        LocalDateTime createAt = Instant.now().atZone(ZoneId.systemDefault()).toLocalDateTime();
        LocalDateTime updateAt = Instant.now().atZone(ZoneId.systemDefault()).toLocalDateTime();

        request = UserCreateRequest.builder()
                .name("tranmanh2005")
                .email("manhbhlc12345@gmail.com")
                .password_has("1234567")
                .phone("0983084800")
                .birthday_year(2005)
                .country("VietNam")
                .avatar_url("https://example.com/avatar.jpg")
                .theme_color("#21966F3")
                .language("vi")
                .is_vip(false)
                .vip_auto_renew(false)
                .vip_expired_at(new Date(Instant.now().plus(29, ChronoUnit.DAYS).toEpochMilli()))
                .two_factor_enable(false)
                .create_at(new Date(Instant.now().toEpochMilli()))
                .update_at(new Date(Instant.now().toEpochMilli()))
                .status("Active")
                .build();


        userResponse = UserResponse.builder()
                .name("tranmanh2005")
                .email("manhbhlc123@gmail.com")
                .phone("0983084800")
                .birthday_year(2005)
                .country("VietNam")
                .avatar_url("https://example.com/avatar.jpg")
                .theme_color("#21966F3")
                .language("vi")
                .is_vip(false)
                .vip_auto_renew(false)
                .vip_expired_at(new Date(Instant.now().plus(29, ChronoUnit.DAYS).toEpochMilli()))
                .two_factor_enable(false)
                .create_at(new Date(Instant.now().toEpochMilli()))
                .update_at(new Date(Instant.now().toEpochMilli()))
                .status("Active").build();

        user = User.builder().name("tranmanh2005")
                .email("manhbhlc123@gmail.com")
                .phone("0983084800")
                .birthYear(2005)
                .country("VietNam")
                .avatarUrl("https://example.com/avatar.jpg")
                .themeColor("#21966F3")
                .language("vi")
                .isVip(false)
                .vipAutoRenew(false)
                .twoFactorEnabled(false)
                .vipExpiredAt(expiry)
                .vipExpiredAt(expiry)
                .createdAt(createAt)
                .updatedAt(updateAt)
                .build();
    }

    @Test
    void createUser_validRequest_success()
    {
        //GIVEN
        Mockito.when(userRepository.existsUsersByName(ArgumentMatchers.anyString())).thenReturn(false);
        Mockito.when(userRepository.save(ArgumentMatchers.any())).thenReturn(user);

        //WHEN
        var response = userService.createUserByUser(request);


        //THEN
        Assertions.assertThat(response.getName()).isEqualTo("tranmanh2005");
        Assertions.assertThat(response.getEmail()).isEqualTo("manhbhlc123@gmail.com");

    }


    @Test
    void createUser_userExisted_success()
    {
        //GIVEN
        Mockito.when(userRepository.existsUsersByName(ArgumentMatchers.anyString())).thenReturn(true);

        //WHEN
        var exception = assertThrows(AppException.class, () -> userService.createUserByUser(request));

        //THEN
        Assertions.assertThat(exception.getErrorCode().getCode()).isEqualTo(1003);

    }

}
