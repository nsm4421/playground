package com.sns.karma.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "Token is invalid"),
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "Username is not founded"),
    INVALID_PASSWORD(HttpStatus.UNAUTHORIZED, "Password is invalid"),
    DUPLICATED_USER_NAME(HttpStatus.CONFLICT, "Duplicated username"),
    DUPLICATED_EMAIL(HttpStatus.CONFLICT, "Duplicated email"),
    DB_ERROR_ON_USER_SERVICE(HttpStatus.CONFLICT, "DB Error"),
    INVALID_PROVIDER(HttpStatus.CONFLICT, "Provider is invalid"),
    POST_NOT_FOUND(HttpStatus.NOT_FOUND, "Posting is not founded"),
    PERMISSION_DENIED(HttpStatus.UNAUTHORIZED, "Authorization failed"),
    ALREADY_LIKED(HttpStatus.CONFLICT, "Already liked")
    ;

    private final HttpStatus status;
    private final String message;
}
