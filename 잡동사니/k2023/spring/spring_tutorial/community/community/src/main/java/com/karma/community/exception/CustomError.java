package com.karma.community.exception;

import lombok.Getter;

@Getter
public class CustomError extends RuntimeException {
    private CustomErrorCode errorCode = CustomErrorCode.INTERNAL_SERVER_ERROR;
    private String message = null;

    private CustomError(CustomErrorCode errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
        this.message = null;
    }

    private CustomError(CustomErrorCode errorCode) {
        this.errorCode = errorCode;
        this.message = errorCode.getMessage();
        this.message = null;
    }

    protected CustomError(){}

    public static CustomError of(CustomErrorCode errorCode, String message){
        return new CustomError(errorCode, message);
    }

    public static CustomError of(CustomErrorCode errorCode){
        return new CustomError(errorCode, errorCode.getMessage());
    }
}
