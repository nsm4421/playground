package com.sns.karma.exception;

import com.sns.karma.controller.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalControllerAdvice {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> applicationHandler(CustomException e){
        String errorMessage = String.format("ERROR : %s", e.toString());
        log.error(errorMessage);
        return ResponseEntity
                .status(e.getErrorCode().getStatus())
                .body(Response.error(e.getErrorCode().name()));
    }
}
