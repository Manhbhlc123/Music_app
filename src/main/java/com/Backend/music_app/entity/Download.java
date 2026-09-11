package com.Backend.music_app.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "downloads", schema = "music_app", indexes = @Index(name = "idx_downloads_user_month", columnList = "user_id, month_key"))
@AllArgsConstructor
@NoArgsConstructor
public class Download {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "song_id", nullable = false)
    Song song;

    @Column(name = "quality", nullable = false, length = 20)
    @Builder.Default
    String quality = "normal";

    @Column(name = "file_local_path")
    String fileLocalPath;

    @Column(name = "month_key", nullable = false, length = 7)
    String monthKey;

    @CreationTimestamp
    @Column(name = "downloaded_at", nullable = false)
    LocalDateTime downloadedAt;


}
