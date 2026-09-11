package com.Backend.music_app.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.Formula;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(schema = "music_app", name = "playlists")
public class Playlist {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    User user;

    @Column(name = "title", nullable = false, length = 200)
    String title;

    @Column(name = "cover_url", columnDefinition = "TEXT")
    String coverUrl;

    @Column(name = "is_system", nullable = false)
    boolean isSystem;

    @Column(name = "is_public", nullable = false)
    boolean isPublic;

    @Column(name = "share_slug", length = 100, unique = true)
    String shareSlug;

    @Column(name = "search_keywords", columnDefinition = "TEXT")
    String searchKeywords;

    @Column(name = "created_at", nullable = false, updatable = false)
    LocalDateTime createdAt;

    @PrePersist
    protected void onCreate()
    {
        this.createdAt = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "playlist", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    List<PlaylistSong> playlistSongs = new ArrayList<>();

    @Formula("(SELECT COUNT(*) FROM music_app.playlist_songs ps WHERE ps.playlist_id = id)")
    Integer totalSong;
}
