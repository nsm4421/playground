package com.sns.karma.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCodeEnum {

    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "User not founded"),
    INVALID_AUTH_INFO(HttpStatus.UNAUTHORIZED, "Invalid username or password"),
    DUPLICATED_USER_NAME(HttpStatus.CONFLICT, "Duplicated user name"),
    INVALID_PROVIDER(HttpStatus.CONFLICT, "Oauth provider is not valid");

    private final HttpStatus status;
    private final String message;
}