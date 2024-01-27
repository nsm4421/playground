package com.karma.hipgora.controller;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MyResponse<T> {
    private String resultCode;
    private T result;

    public static <T> MyResponse<T> success() {
        return new MyResponse<T>("SUCCESS", null);
    }

    public static <T> MyResponse<T> success(T result) {
        return new MyResponse<T>("SUCCESS", result);
    }

    public static MyResponse<Void> error(String resultCode) {
        return new MyResponse<Void>(resultCode, null);
    }

    public String toStream() {
        if (result == null) {
            return String.format("Result Code : %s", resultCode);
        }
        return String.format("Result Code : %s \n Result : %s", resultCode, result);
    }
}