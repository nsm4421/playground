package com.karma.myapp.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;


@Getter
@AllArgsConstructor
public enum CustomErrorCode {
    ENTITY_NOT_FOUND(HttpStatus.NOT_FOUND, "Entity not found"),
    INVALID_PASSWORD(HttpStatus.UNAUTHORIZED, "password is wrong"),
    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "Token is invalid"),
    NOT_GRANT(HttpStatus.UNAUTHORIZED, "Not granted access"),
    INVALID_PARAMETER(HttpStatus.CONFLICT, "Given parameter is invalid"),
    DUPLICATED_ENTITY(HttpStatus.CONFLICT,"Entity is duplicated"),
    INTERNAL_SERVER_ERROR(HttpStatus.CONFLICT,"Server error")
    ;
    private final HttpStatus httpStatus;
    private final String message;
}
