package com.karma.meeting.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum CustomErrorCode {
    DUPLICATED_ENTITY(HttpStatus.CONFLICT, "중복된 엔티티입니다"),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "서버 에러 발생"),
    ENTITY_NOT_FOUNDED(HttpStatus.NOT_FOUND, "존재하지 않는 엔티티입니다"),
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "인증되지 않은 접근입니다");
    private final HttpStatus status;
    private final String message;
}
