package com.sns.karma.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "토큰이 유효하지 않습니다."),
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "해당 유저아이디는 존재하지 않습니다."),
    INVALID_PASSWORD(HttpStatus.UNAUTHORIZED, "비밀번호가 유효하지 않습니다."),
    DUPLICATED_USER_NAME(HttpStatus.CONFLICT, "중복된 유저명입니다."),
    DUPLICATED_EMAIL(HttpStatus.CONFLICT, "중복된 이메일입니다."),
    DB_ERROR_ON_USER_SERVICE(HttpStatus.CONFLICT, "User Servide에서 DB 에러가 발생했습니다."),
    INVALID_PROVIDER(HttpStatus.CONFLICT, "Provider가 유효하지 않습니다.")
    ;

    private final HttpStatus status;
    private final String message;
}
