package com.karma.prj.exception;

import com.karma.prj.model.util.CustomResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalControllerAdvice {
    /**
     * @param error
     * CustomException에서 정의된 에러
     * @return
     * body에 CustomErrorCode 이름
     */
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> applicationHandler(CustomException error){
        log.error("Error occurs... {}", error.toString());
        return ResponseEntity.status(error.getCode().getStatus())
                .body(CustomResponse.error(error.getCode().name()));
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<?> applicationHandler(RuntimeException error){
        log.error("Error occurs... {}", error.toString());
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(CustomResponse.error(CustomErrorCode.INTERNAL_SERVER_ERROR.name()));
    }
}
