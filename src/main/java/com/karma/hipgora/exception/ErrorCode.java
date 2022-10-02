package com.karma.hipgora.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "User is not founded"),
    FILE_UPLOAD_FAILURE(HttpStatus.CONFLICT, "Error occurs when uploading file"),
    DUPLICATED_USERNAME(HttpStatus.CONFLICT, "Username is duplicated"),
    DUPLICATED_EMAIL(HttpStatus.CONFLICT, "Email is duplicated"),
    INVALID_PASSWORD(HttpStatus.CONFLICT, "Password is wrong"),
    INVALID_TOKEN(HttpStatus.CONFLICT, "Auth token is invalid");

    private final HttpStatus status;
    private String errorMessage;
}
