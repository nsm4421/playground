package com.sns.karma.controller;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomResponse<T> {
    private String resultCode;
    private T result;

    public static <T> CustomResponse<T> success() {
        return new CustomResponse<T>("SUCCESS", null);
    }

    public static <T> CustomResponse<T> success(T result) {
        return new CustomResponse<T>("SUCCESS", result);
    }

    public static CustomResponse<Void> error(String resultCode) {
        return new CustomResponse<Void>(resultCode, null);
    }

    public String toStream() {
        if (result == null) {
            return "{" +
                    "\"resultCode\":" + "\"" + resultCode + "\"," +
                    "\"result\":" + null +
                    "}";
        }
        return "{" +
                "\"resultCode\":" + "\"" + resultCode + "\"," +
                "\"result\":" + "\"" + result + "\"," +
                "}";
    }
}