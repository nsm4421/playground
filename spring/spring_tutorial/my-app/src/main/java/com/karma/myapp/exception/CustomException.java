package com.karma.myapp.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomException extends RuntimeException{
    private CustomErrorCode customErrorCode;
    private String message;

    private CustomException(CustomErrorCode customErrorCode, String message) {
        this.customErrorCode = customErrorCode;
        this.message = message;
    }

    protected CustomException(){}

    public static CustomException of(CustomErrorCode customErrorCode){
        return new CustomException(customErrorCode, customErrorCode.getMessage());
    }

    public static CustomException of(CustomErrorCode customErrorCode, String message){
        return new CustomException(customErrorCode, message);
    }
}
