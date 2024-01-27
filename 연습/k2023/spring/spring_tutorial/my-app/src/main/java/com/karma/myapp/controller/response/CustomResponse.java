package com.karma.myapp.controller.response;

import com.karma.myapp.exception.CustomErrorCode;

public record CustomResponse<T>(T data, String message) {
    public static <T> CustomResponse<T> success() {
        return new CustomResponse<>(null, null);
    }

    public static <T> CustomResponse<T> success(T data) {
        return new CustomResponse<>(data, null);
    }

    public static <T> CustomResponse<T> success(T data, String message) {
        return new CustomResponse<>(data, message);
    }

    public static <T> CustomResponse<T> error(String message) {
        return new CustomResponse<T>(null, message);
    }

    public static <T> CustomResponse<T> error(CustomErrorCode customErrorCode) {
        return new CustomResponse<T>(null, customErrorCode.getMessage());
    }

    public String toJson(){
        return "{" +
                "\"message\":" + "\"" + message + "\"," +
                "\"data\":" + (data==null?"null":data) +
                "}";
    }
}
