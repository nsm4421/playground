package com.karma.board.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    DUPLICATED_USER("이미 존재하는 유저명입니다"),
    DUPLICATED_EMAIL("이미 존재하는 이메일입니다");
    private String description;
}
