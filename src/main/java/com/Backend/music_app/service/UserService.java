package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.UserCreateRequest;
import com.Backend.music_app.dto.request.update.UserUpdateRequest;
import com.Backend.music_app.dto.response.UserResponse;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.enums.RoleEnum;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.UserMapper;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserService {
    UserRepository userRepository;
    UserMapper userMapper;
    PasswordEncoder passwordEncoder;

    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public UserResponse createUserByAdmin(UserCreateRequest request) {

        log.info("Service: Create User");

        if (userRepository.existsUsersByName(request.getName()))
            throw new AppException(ErrorCode.USER_EXISTED);

        User user = userMapper.toUser(request);

        user.setPasswordHash(passwordEncoder.encode(request.getPassword_has()));

        user.setRole(RoleEnum.USER.name());

        return userMapper.toUserResponse(userRepository.save(user));

    }


    public UserResponse createUserByUser(UserCreateRequest request) {

        if (userRepository.existsUsersByName(request.getName()))
            throw new AppException(ErrorCode.USER_EXISTED);

        User user = userMapper.toUser(request);

        user.setPasswordHash(passwordEncoder.encode(request.getPassword_has()));

//        user.setRole(RoleEnum.ADMIN.name());
        user.setRole(RoleEnum.USER.name());

        return userMapper.toUserResponse(userRepository.save(user));

    }

    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public List<UserResponse> getUsers() {
        log.info("IN method get Users");
        return userRepository.findAll().stream().map(userMapper::toUserResponse).toList();
    }

    @PostAuthorize("returnObject.name == authentication.name")
    public UserResponse getUser(UUID id) {
        log.info("In method get user by id");
        return userMapper.toUserResponse(userRepository.findById(id).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED)));
    }


    public UserResponse getMyInfo()
    {

        var context = SecurityContextHolder.getContext();
        String name = context.getAuthentication().getName();

        User user = userRepository.findUsersByName(name).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        return userMapper.toUserResponse(user);
    }

    public UserResponse updateUser(UUID userId, UserUpdateRequest request) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        userMapper.updateUser(user, request);
        User updatedUser = userRepository.save(user);

        return userMapper.toUserResponse(updatedUser);
    }


    public void deleteUser(UUID userId) {
        userRepository.deleteById(userId);
    }

    public long CountUser()
    {
        long userCount = userRepository.count();
        return userCount;
    }
}
