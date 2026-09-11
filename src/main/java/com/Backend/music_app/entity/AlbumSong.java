package com.Backend.music_app.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(schema = "music_app", name = "album_songs", uniqueConstraints = {
        @UniqueConstraint(name = "uk_album_song", columnNames = {"album_id", "song_id"})
})
public class AlbumSong {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "album_id", nullable = false)
    Album album;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "song_id", nullable = false)
    Song song;

    @Builder.Default
    @Column(name = "order_index", nullable = false)
    int orderIndex = 0;
}
