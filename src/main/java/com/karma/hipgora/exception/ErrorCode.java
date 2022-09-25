package com.karma.hipgora.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "User is not founded"),
    FILE_UPLOAD_FAILURE(HttpStatus.CONFLICT, "Error occurs when uploading file");
    private final HttpStatus status;
    private String errorMessage;
}
