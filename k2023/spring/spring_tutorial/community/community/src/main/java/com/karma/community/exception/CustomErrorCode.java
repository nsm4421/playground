package com.karma.community.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum CustomErrorCode {

    DUPLICATED_USER_INFO(HttpStatus.CONFLICT, "중복된 유저 정보입니다"),
    DUPLICATED_EMOTION(HttpStatus.CONFLICT, "중복된 감정표현입니다"),
    INVALID_INPUT(HttpStatus.BAD_REQUEST, "유효하지 않은 요청입니다"),
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 유저입니다"),
    ARTICLE_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 게시물입니다"),
    ARTICLE_COMMENT_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 댓글입니다"),
    UNAUTHORIZED_ACCESS(HttpStatus.UNAUTHORIZED, "인증되지 않은 접근입니다"),
    KAKAO_OAUTH_FAIL(HttpStatus.UNAUTHORIZED, "소셜로그인(카카오)이 실패하였습니다."),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "서버 오류가 발생했습니다")
    ;
    private final HttpStatus httpStatus;
    private final String message;
}
