package com.Backend.music_app.dto.response;


import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class IntrospectResponse {
    boolean valid;
}
