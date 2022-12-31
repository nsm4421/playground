package com.karma.board.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MyException extends RuntimeException{
    private ErrorCode errorCode;
    private String message = null;

    @Override
    public String getMessage() {
        return message ==null
                ?errorCode.getDescription()
                :String.format("Error Code : %s \n Error message : %s", errorCode.getDescription(), message);
    }
}
