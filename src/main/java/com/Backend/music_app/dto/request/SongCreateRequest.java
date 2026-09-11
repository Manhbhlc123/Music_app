package com.Backend.music_app.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SongCreateRequest {

    String title;

    // Chỉ nhận ID (chuỗi hoặc số) từ Frontend gửi xuống
    UUID artistId;
    UUID albumId;
    UUID genreId;

    int duration;
    String audioUrlNormal;
    String audioUrlHq;
    String coverUrl;
    String lyricsPlain;

}