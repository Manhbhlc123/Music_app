package com.Backend.music_app.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(schema = "music_app", name = "song_lyrics_sync")
@Builder
public class SongLyricSync {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "song_id", nullable = false)
    Song song;

    @Column(name = "time_start", nullable = false)
    int timeStart;

    @Column(name = "time_end", nullable = false)
    int timeEnd;

    @Column(name = "line_text", nullable = false, columnDefinition = "TEXT")
    String lineText;

    @Column(name = "line_order", nullable = false)
    int lineOrder;

}
