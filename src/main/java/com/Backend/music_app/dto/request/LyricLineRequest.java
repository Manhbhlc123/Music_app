package com.Backend.music_app.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LyricLineRequest {
    int timeStart;
    int timeEnd;
    String lineText;
    int lineOrder;
}
