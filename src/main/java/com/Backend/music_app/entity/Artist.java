package com.Backend.music_app.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.Formula;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(schema = "music_app", name = "artists")
public class Artist {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @Column(name = "name", nullable = false, length = 150)
    String name;

    @Column(name = "avatar_url", columnDefinition = "TEXT")
    String avatarUrl;

    @Column(name = "bio", columnDefinition = "TEXT")
    String bio;

    @Column(name = "country", length = 100)
    String country;

    @Builder.Default
    @Column(name = "is_verified", nullable = false)
    boolean isVerified = false;

    @Column(name = "search_keywords", columnDefinition = "TEXT")
    String searchKeywords;

    @Column(name = "created_at", nullable = false, updatable = false)
    LocalDateTime createdAt;

    // Tự động gán thời gian tạo
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    @Formula("(SELECT COUNT(*) FROM music_app.follows f WHERE f.artist_id = id)")
    @Builder.Default
    Long followerCount = 0L;
}