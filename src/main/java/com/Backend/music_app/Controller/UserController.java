package com.Backend.music_app.Controller;

import com.Backend.music_app.dto.response.ApiResponse;
import com.Backend.music_app.dto.request.UserCreateRequest;
import com.Backend.music_app.dto.request.update.UserUpdateRequest;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.service.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RestController
@RequestMapping("/users")
@Log4j2
public class UserController {
    UserService userService;

    @PostMapping("/create/admin")
    ApiResponse<UserResponse> createUserByAdmin(@RequestBody @Valid UserCreateRequest request) {
        log.info("controller: create User");
        return ApiResponse.<UserResponse>builder().code(201).result(userService.createUserByAdmin(request)).build();
    }


    @PostMapping("/create/user")
    ApiResponse<UserResponse> createUserByUser(@RequestBody @Valid UserCreateRequest request) {
        log.info("controller: User create by user");
        return ApiResponse.<UserResponse>builder().code(201).result(userService.createUserByUser(request)).build();
    }

    @GetMapping
    ApiResponse<List<UserResponse>> getUsers() {
        var authentication = SecurityContextHolder.getContext().getAuthentication();

        log.info("Username: {}", authentication.getName());
        authentication.getAuthorities().forEach(grantedAuthority -> log.info(grantedAuthority.getAuthority()));
        return ApiResponse.<List<UserResponse>>builder().code(200).result(userService.getUsers()).build();
    }

    @GetMapping("/{userId}")
    ApiResponse<UserResponse> getUser(@PathVariable("userId") UUID userId) {
        return ApiResponse.<UserResponse>builder().code(200).result(userService.getUser(userId)).build();
    }

    @PutMapping("/{userId}")
    ApiResponse<UserResponse> updateUser(@PathVariable UUID userId, @RequestBody UserUpdateRequest request) {
        return ApiResponse.<UserResponse>builder().code(200).result(userService.updateUser(userId, request)).build();
    }

    @DeleteMapping("/{userId}")
    ApiResponse<String> deleteUser(@PathVariable UUID userId) {
        userService.deleteUser(userId);
        return ApiResponse.<String>builder().code(200).result("User has been deleted").build();
    }

    @GetMapping("/myInfo")
    ApiResponse<UserResponse> getMyInfo()
    {
        return ApiResponse.<UserResponse>builder().code(200).result(userService.getMyInfo()).build();
    }

    @GetMapping("/count")
    ApiResponse<Long> getUserCount()
    {
        return ApiResponse.<Long>builder().code(200).result(userService.CountUser()).build();
    }

}
