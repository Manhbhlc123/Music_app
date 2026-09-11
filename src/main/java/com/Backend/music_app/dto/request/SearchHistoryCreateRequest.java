package com.Backend.music_app.dto.request;

import com.Backend.music_app.enums.ResultType;
import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.UUID;


@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SearchHistoryCreateRequest {

    @NotBlank(message = "Từ khóa không được để trống")
    String keyword;

    ResultType resultType;

    UUID clickResultId;
}
