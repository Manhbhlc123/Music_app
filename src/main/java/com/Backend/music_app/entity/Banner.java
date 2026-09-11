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
@Table(schema = "music_app", name = "banners")
public class Banner {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", nullable = false, updatable = false)
    UUID id;

    @Column(name = "title", length = 200)
    String title;

    @Column(name = "image_url", columnDefinition = "TEXT")
    String imageUrl;

    /**
     * Dùng để biết banner bấm vào sẽ điều hướng đi đâu.
     * Ví dụ: "PLAYLIST", "SONG", "ALBUM", "EXTERNAL_WEB", hoặc "NONE"
     */
    @Column(name = "redirect_type", length = 30)
    String redirectType;

    /**
     * ID của Entity đích (ID của Playlist, Song, v.v. cần chuyển hướng tới).
     * Để nullable vì có những banner chỉ hiển thị thông báo, không click được.
     */
    @Column(name = "redirect_id")
    UUID redirectId;

    /**
     * Thứ tự hiển thị Banner trên Carousel/Slider ở màn hình Home (1, 2, 3...)
     */
    @Column(name = "sort_order")
    Integer sortOrder;

    /**
     * Trạng thái bật/tắt banner.
     * Dùng Boolean (object) kết hợp @Builder.Default để tránh lỗi bị false khi dùng Builder
     */
    @Builder.Default
    @Column(name = "is_active")
    Boolean isActive = true;
}