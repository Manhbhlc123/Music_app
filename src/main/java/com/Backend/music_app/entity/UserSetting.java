package com.Backend.music_app.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.apachecommons.CommonsLog;
import org.hibernate.annotations.JdbcType;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.Map;
import java.util.UUID;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(schema = "music_app", name = "user_settings")
public class UserSetting {
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    User user;

    @Column(name = "download_only_wifi", nullable = false)
    @Builder.Default
    boolean downloadOnlyWifi = false;


    @Column(name = "notification_enabled", nullable = false)
    @Builder.Default
    boolean notificationEnabled = true;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "equalizer_preset", columnDefinition = "jsonB")
    Map<String, Object> equalizerPreset;
}
