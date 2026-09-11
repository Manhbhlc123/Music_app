package com.Backend.music_app.exception;


import com.Backend.music_app.dto.response.ApiResponse;
import jakarta.validation.ConstraintViolation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.TransactionSystemException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.nio.file.AccessDeniedException;
import java.text.ParseException;
import java.util.Map;
import java.util.Objects;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandle {

    private static final String MIN_ATTRIBUTE = "min";
    //xử lý các ngoại lệ không có trong enum
    @ExceptionHandler(value = RuntimeException.class)
    ResponseEntity<ApiResponse> handleRuntimeException(RuntimeException exception) {
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setCode(ErrorCode.UNCATEGORIZED_EXCEPTION.getCode());
        apiResponse.setMessage(ErrorCode.UNCATEGORIZED_EXCEPTION.getMessage());
        return ResponseEntity.status(ErrorCode.UNCATEGORIZED_EXCEPTION.getHttpStatus()).body(apiResponse);
    }

    //xử lý ngoại lệ khi báo ra lỗi AppException
    @ExceptionHandler(value = AppException.class)
    ResponseEntity<ApiResponse> handleAppException(AppException exception) {
        ApiResponse apiResponse = new ApiResponse();
        ErrorCode errorCode = exception.getErrorCode();

        apiResponse.setCode(errorCode.getCode());
        apiResponse.setMessage(errorCode.getMessage());

        return ResponseEntity
                .status(errorCode.getHttpStatus())
                .body(apiResponse);
    }


    //Xử lý ngoại lệ của validate thuộc tính
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    ResponseEntity<ApiResponse> handleAppValidation(MethodArgumentNotValidException exception) {
        String enumkey = exception.getFieldError().getDefaultMessage();
        ErrorCode errorCode = ErrorCode.INVALID_KEY;

        Map<String, Object> attribute = null;

        try {
            errorCode = ErrorCode.valueOf(enumkey);

            var contrainViolation = exception.getBindingResult().getAllErrors().getFirst().unwrap(ConstraintViolation.class);

            attribute = contrainViolation.getConstraintDescriptor().getAttributes();

            log.info(attribute.toString());


        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setCode(errorCode.getCode());
        apiResponse.setMessage(Objects.nonNull(attribute) ?
                mapAttribute(errorCode.getMessage(), attribute) : errorCode.getMessage());

        return ResponseEntity.status(errorCode.getHttpStatus()).body(apiResponse);
    }

    @ExceptionHandler(value = AccessDeniedException.class)
    ResponseEntity<ApiResponse> handlingAccessDeniedException(AccessDeniedException exception) {
        ErrorCode errorCode = ErrorCode.UNAUTHORIZED;
        return ResponseEntity.status(errorCode.getHttpStatus())
                .body(ApiResponse.builder().code(errorCode.getCode()).message(errorCode.getMessage())
                        .build());
    }

    @ExceptionHandler(value = TransactionSystemException.class)
    ResponseEntity<ApiResponse> handlingTransactionSystemException(TransactionSystemException exception)
    {
        ErrorCode errorCode = ErrorCode.CANT_COMMIT;
        return ResponseEntity.status(errorCode.getHttpStatus())
                .body(ApiResponse.builder().code(errorCode.getCode()).message(errorCode.getMessage())
                        .build());
    }

    private String mapAttribute(String message, Map<String, Object> attribute)
    {
        String minValue = String.valueOf(attribute.get(MIN_ATTRIBUTE));

        return message.replace("{" + MIN_ATTRIBUTE + "}", minValue);
    }

}
