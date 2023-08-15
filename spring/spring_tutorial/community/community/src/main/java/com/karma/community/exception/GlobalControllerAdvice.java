package com.karma.community.exception;

import com.karma.community.model.util.CustomResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalControllerAdvice {
    @ExceptionHandler(RuntimeException.class)
    public CustomResponse<Object> handleRuntimeException(final RuntimeException e) {
        log.error("[handleRuntimeException] GlobalControllerAdvice에서 오류 발생");
        return CustomResponse.error(CustomErrorCode.INTERNAL_SERVER_ERROR, e.getMessage());
    }
}
