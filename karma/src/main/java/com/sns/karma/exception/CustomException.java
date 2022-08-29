package com.sns.karma.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomException extends RuntimeException{
    private ErrorCodeEnum errorCode;
    private String message = null;


    @Override
    public String getMessage() {
        if (message == null) {
            return errorCode.getMessage();
        } else {
            return String.format("Error Code : %s | Error message : %s", errorCode.getMessage(), message);
        }
    }
}
