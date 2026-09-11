package com.Backend.music_app.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
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
@Table(schema = "music_app", name = "albums")
public class Album {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    UUID id;

    @Column(name = "title", nullable = false, length = 200)
    String title;

    // Mapping khóa ngoại artist_id sang Entity Artist
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "artist_id", nullable = false)
    Artist artist;

    @Column(name = "cover_url", columnDefinition = "TEXT")
    String coverUrl;

    @Column(name = "release_date")
    LocalDate releaseDate;

    @Column(name = "description", columnDefinition = "TEXT")
    String description;

    @Column(name = "search_keywords", columnDefinition = "TEXT")
    String searchKeywords;

    @Column(name = "created_at", nullable = false, updatable = false)
    LocalDateTime createdAt;

    // Tự động gán thời gian tạo
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "album", cascade = CascadeType.ALL)
    @Builder.Default
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    List<Song> songs = new ArrayList<>();
}