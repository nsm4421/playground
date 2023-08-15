package com.karma.myapp.exception;

import com.karma.myapp.controller.response.CustomResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalControllerAdvice {
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> applicationHandler(CustomException e){
        log.error("CustomError : {}", e.getMessage());
        return ResponseEntity
                .status(e.getCustomErrorCode().getHttpStatus())
                .body(CustomResponse.error(e.getMessage()).toJson());
    }
}
