package com.Backend.music_app.config;

import com.Backend.music_app.entity.User;
import com.Backend.music_app.enums.RoleEnum;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.java.Log;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;

@Configuration
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@Log
public class ApplicatonInitConfig {


    PasswordEncoder passwordEncoder;

    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository) {
        return args -> {
            if(userRepository.findUsersByEmail("manhbhlc123@gmail.com").isEmpty())
            {

                LocalDateTime expiry = Instant.now().plus(29, ChronoUnit.DAYS).atZone(ZoneId.systemDefault()).toLocalDateTime();
                LocalDateTime createAt = Instant.now().atZone(ZoneId.systemDefault()).toLocalDateTime();
                LocalDateTime updateAt = Instant.now().atZone(ZoneId.systemDefault()).toLocalDateTime();

                User user = User.builder()
                        .name("tranmanh")
                        .email("manhbhlc123@gmail.com")
                        .passwordHash(passwordEncoder.encode("1234567"))
                        .phone("0983084860")
                        .birthYear(2005)
                        .country("VietNam")
                        .avatarUrl("https://example.com/avatar.jpg")
                        .themeColor("#21966F3")
                        .language("vi")
                        .isVip(false)
                        .vipAutoRenew(false)
                        .vipExpiredAt(expiry)
                        .twoFactorEnabled(false)
                        .createdAt(createAt)
                        .updatedAt(updateAt)
                        .status("Active")
                        .build();


                userRepository.save(user);
                log.warning("admin user has been create with default password: 1234567, please change it");
            }
        };
    }
}
