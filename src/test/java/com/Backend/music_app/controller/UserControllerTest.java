package com.Backend.music_app.controller;

import com.Backend.music_app.dto.request.UserCreateRequest;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.assertj.MockMvcTester;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import static org.mockito.ArgumentMatchers.any;

@Slf4j
@SpringBootTest
@AutoConfigureMockMvc
public class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private UserService userService;

    private UserCreateRequest request;
    private UserResponse userResponse;


    @BeforeEach
    void initData() {
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
    }

    @Test
    void createUser_validRequest_success() throws Exception {
        //GIVEN
        request.setName("manhtr");
        ObjectMapper objectMapper = new ObjectMapper();
        String content = objectMapper.writeValueAsString(request);

//        Mockito.when(userService.createUserByAdmin(any())).thenReturn(userResponse);


        //WHEN, THEN
        mockMvc.perform(MockMvcRequestBuilders.post("/users/create/user")
                        .contentType(MediaType.APPLICATION_JSON_VALUE)
                        .content(content))
                .andExpect(MockMvcResultMatchers.status().isBadRequest())
                .andExpect(MockMvcResultMatchers.jsonPath("code").value(1001))
                .andExpect(MockMvcResultMatchers.jsonPath("message").value("Username must be at least 8 characters")
                );
    }

}
