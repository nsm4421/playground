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
    INVALID_PROVIDER(HttpStatus.CONFLICT, "Provider가 유효하지 않습니다."),
    POST_NOT_FOUND(HttpStatus.NOT_FOUND, "포스팅이 존재하지 않습니다."),
    PERMISSION_DENIED(HttpStatus.UNAUTHORIZED, "인증이 거부당했습니다."),
    ALREADY_LIKED(HttpStatus.CONFLICT, "이미 좋아요를 눌렀습니다."),
    INVALID_KEYWORD(HttpStatus.NO_CONTENT, "잘못된 키워드로 검색하였습니다.")
    ;

    private final HttpStatus status;
    private final String message;
}
