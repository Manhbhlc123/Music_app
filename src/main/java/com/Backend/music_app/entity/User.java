package com.Backend.music_app.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(schema = "music_app", name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    UUID id;

    @Column(name = "name", nullable = false, length = 100)
    String name;

    @Column(name = "email", unique = true, length = 150)
    String email;

    @Column(name = "password_has", length = 255)
    String passwordHash;

    @Column(name = "phone", unique = true, length = 20)
    String phone;

    @Column(name = "birth_year")
    Integer birthYear;

    @Column(name = "country", length = 100)
    String country;

    @Column(name = "avatar_url", columnDefinition = "TEXT")
    String avatarUrl;

    @Column(name = "theme_color", length = 20)
    String themeColor;

    @Column(name = "language", length = 10)
    String language;

    @Column(name = "role", nullable = false, length = 20)
    String role;

    @Column(name = "is_vip", nullable = false)
    boolean isVip;

    @Column(name = "vip_auto_renew", nullable = false)
    boolean vipAutoRenew;

    @Column(name = "vip_expired_at")
    LocalDateTime vipExpiredAt;

    @Column(name = "two_factor_enabled", nullable = false)
    boolean twoFactorEnabled;

    @Column(name = "status", nullable = false, length = 20)
    String status;

    @Column(name = "created_at", nullable = false, updatable = false)
    LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    LocalDateTime updatedAt;

    // Tự động gán thời gian tạo/cập nhật trước khi lưu vào DB
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

}