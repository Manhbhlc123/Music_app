package com.Backend.music_app.exception;


import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

//tạo các mã exception có thể xuất hiện
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
public enum ErrorCode {
    UNCATEGORIZED_EXCEPTION(9999, "Uncategorized exception", HttpStatus.INTERNAL_SERVER_ERROR),
    INVALID_KEY(0001, "Invalid message key", HttpStatus.BAD_REQUEST),
    USERNAME_INVALID(1001, "Username must be at least {min} characters", HttpStatus.BAD_REQUEST),
    INVALID_PASSWORD(1002, "Password must be at least {min} characters", HttpStatus.BAD_REQUEST),
    USER_EXISTED(1003, "User existed", HttpStatus.BAD_REQUEST),
    UNAUTHENTICATED(1004, "Unauthenticated", HttpStatus.UNAUTHORIZED),
    UNDEFINED(1005, "Undefined token", HttpStatus.BAD_REQUEST),
    USER_NOT_EXISTED(1006, "User not existed", HttpStatus.NOT_FOUND),
    UNAUTHORIZED(1007, "You do not have permission", HttpStatus.FORBIDDEN),
    INVALID_DOB(1008, "Your age must be at least {min}", HttpStatus.BAD_REQUEST),
    CANT_COMMIT(1009, "You can't commnit this data",HttpStatus.INTERNAL_SERVER_ERROR),
    INVALID_EMAIL(1010, "Email is not valid", HttpStatus.BAD_REQUEST),
    SONG_EXISTED(1011, "Song existed", HttpStatus.BAD_REQUEST),
    GENRES_EXISTED(1012, "Genre existed", HttpStatus.BAD_REQUEST),
    ARTIST_EXISTED(1012, "Artist existed", HttpStatus.BAD_REQUEST),
    ALBUM_EXISTED(1012, "Album existed", HttpStatus.BAD_REQUEST),
    ARTIST_NOT_FOUND(1013, "Artist not found", HttpStatus.BAD_REQUEST),
    GENRES_NOT_FOUND(1014, "genres not found", HttpStatus.BAD_REQUEST),
    ALBUM_NOT_FOUND(1014, "Album not found", HttpStatus.BAD_REQUEST),
    PLAYLIST_EXISTED(1015, "Playlist existed", HttpStatus.BAD_REQUEST),
    BANNER_EXISTED(1016, "Banner existed", HttpStatus.BAD_REQUEST),
    SONG_NOT_FOUND(1016, "Song not found", HttpStatus.BAD_REQUEST),
    PLAYLIST_NOT_FOUND(1016, "Playlist not found", HttpStatus.BAD_REQUEST),

    ;

    private int code;
    private String message;
    private HttpStatusCode httpStatus;

    ErrorCode(int code, String message, HttpStatusCode httpStatusCode) {
        this.code = code;
        this.message = message;
        this.httpStatus = httpStatusCode;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
