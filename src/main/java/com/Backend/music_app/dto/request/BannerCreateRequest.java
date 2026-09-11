package com.Backend.music_app.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BannerCreateRequest {

    @JsonProperty("title")
    String title;

    @JsonProperty("imageUrl")
    String imageUrl;

    /**
     * Ví dụ: "PLAYLIST", "SONG", "ALBUM", "EXTERNAL_WEB", hoặc "NONE"
     */
    @JsonProperty("redirectType")
    String redirectType;

    /**
     * UUID của Playlist hoặc Song mà banner cần điều hướng tới
     */
    @JsonProperty("redirectId")
    UUID redirectId;

    @JsonProperty("sortOrder")
    Integer sortOrder;

    /**
     * Cho phép Admin chọn bật/tắt banner ngay lúc tạo (mặc định là true)
     */
    @Builder.Default
    @JsonProperty("isActive")
    Boolean isActive = true;
}