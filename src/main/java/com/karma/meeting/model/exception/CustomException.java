package com.karma.meeting.model.exception;

import com.karma.meeting.model.enums.CustomErrorCode;
import lombok.Getter;

@Getter
public class CustomException extends RuntimeException{
    private CustomErrorCode customErrorCode;
    private String message = null;

    public CustomException(CustomErrorCode customErrorCode) {
        this.customErrorCode = customErrorCode;
        this.message = customErrorCode.getMessage();
    }

    public CustomException(CustomErrorCode customErrorCode, String message) {
        this.customErrorCode = customErrorCode;
        this.message = message;
    }

}
