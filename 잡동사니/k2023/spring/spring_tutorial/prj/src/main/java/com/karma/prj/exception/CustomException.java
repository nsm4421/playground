package com.karma.prj.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomException extends RuntimeException {
    private CustomErrorCode code;
    private String message;

    private CustomException(CustomErrorCode code) {
        this.code = code;
        this.message = null;
    }

    private CustomException(CustomErrorCode code, String message) {
        this.code = code;
        this.message = message;
    }

    protected CustomException(){}

    public static CustomException of(CustomErrorCode code){
        return new CustomException(code);
    }

    public static CustomException of(CustomErrorCode code, String message){
        return new CustomException(code, message);
    }
}
