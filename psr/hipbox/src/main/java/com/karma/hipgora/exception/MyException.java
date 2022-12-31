package com.karma.hipgora.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MyException extends RuntimeException{
    private ErrorCode errorCode;
    private String errorMessage = null;


    @Override
    public String getMessage() {
        if (errorMessage == null) {
            return errorCode.getErrorMessage();
        } else {
            return String.format("Error Code : %s \n Error message : %s",
                    errorCode.getErrorMessage(),
                    errorMessage);
        }
    }
}