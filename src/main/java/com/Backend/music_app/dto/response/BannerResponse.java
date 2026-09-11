package com.Backend.music_app.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BannerResponse {
    UUID id;
    String title;
    String imageUrl;
    String redirectType;
    UUID redirectId;
    Integer sortOrder;
    Boolean isActive;
}
