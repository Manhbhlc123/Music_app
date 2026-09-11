package com.Backend.music_app.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigInteger;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "songs", schema = "music_app")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Song {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @Column(nullable = false, length = 200)
    String title;

    // --- MỐI QUAN HỆ KHÓA NGOẠI ---

    // 1. Khóa ngoại tới bảng Artists (NOT NULL)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "artist_id", nullable = false)
    Artist artist;

    // 2. Khóa ngoại tới bảng Albums (Có thể NULL)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "album_id")
    Album album;

    // 3. Khóa ngoại tới bảng Genres (Có thể NULL)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "genre_id")
    Genres genre;

    // ---------------------------------

    @Column(nullable = false)
    int duration;

    @Column(name = "audio_url_normal", nullable = false)
    String audioUrlNormal;

    @Column(name = "audio_url_hq")
    String audioUrlHq;

    @Column(name = "cover_url")
    String coverUrl;

    @Column(name = "lyrics_plain", columnDefinition = "TEXT")
    String lyricsPlain;

    @Column(name = "release_date")
    LocalDate releaseDate;

    @Column(name = "play_count", nullable = false)
    Long playCount = 0L;

    @Column(name = "is_active", nullable = false)
    boolean isActive;

    @Column(name = "search_keywords", columnDefinition = "TEXT")
    String searchKeywords;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    LocalDateTime createdAt;

    @OneToMany(mappedBy = "song", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    List<PlaylistSong> playlistSongs = new ArrayList<>();
}