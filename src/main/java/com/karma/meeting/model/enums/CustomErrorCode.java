package com.karma.meeting.model.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum CustomErrorCode {
    ENTITY_NOT_FOUNDED(HttpStatus.NOT_FOUND, "존재하지 않는 엔티티입니다"),
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "인증되지 않은 접곤읍니다.");
    private final HttpStatus status;
    private final String message;
}
