package com.karma.prj.model.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomResponse<T> {
    private String statusCode;
    private T result;

    private CustomResponse(String statusCode, T result) {
        this.statusCode = statusCode;
        this.result = result;
    }

    protected CustomResponse(){}

    public static <T> CustomResponse<T> success() {
        return new CustomResponse<T>("SUCCESS", null);
    }

    public static <T> CustomResponse<T> success(T result) {
        return new CustomResponse<T>("SUCCESS", result);
    }

    public static CustomResponse<Void> error(String resultCode) {
        return new CustomResponse<Void>(resultCode, null);
    }

    public static String json(CustomResponse res){
        if (res.result == null) {
            return "{" +
                    "\"resultCode\":" + "\"" + res.statusCode + "\"," +
                    "\"result\":" + null + "}";
        }
        return "{" +
                "\"resultCode\":" + "\"" + res.statusCode + "\"," +
                "\"result\":" + "\"" + res.result.toString() + "\"" + "}";
    }
}
