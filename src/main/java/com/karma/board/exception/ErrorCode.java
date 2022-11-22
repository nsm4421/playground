package com.karma.board.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    DUPLICATED_USER("Invalid Username"),
    DUPLICATED_EMAIL("Invalid Email"),
    USER_NOT_FOUND("User not founded"),
    INVALID_PARAMETER("Invalid parameter"),
    ENTITY_NOT_FOUND("Entity is not founded");
    private String description;
}
