package com.karma.community.model.util;

import com.karma.community.exception.CustomErrorCode;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class CustomResponse<T> {

    private HttpStatus status;
    private String message;
    private T data;

    private CustomResponse(HttpStatus status, String message, T data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    protected CustomResponse() {
    }

    public static <T> CustomResponse<T> of(HttpStatus status, String message, T data) {
        return new CustomResponse<T>(status, message, data);
    }

    public static <T> CustomResponse<T> success(HttpStatus status, String message, T data) {
        return CustomResponse.of(status, message, data);
    }

    public static <T> CustomResponse<T> success(String message, T data) {
        return CustomResponse.of(HttpStatus.OK, message, data);
    }

    public static <T> CustomResponse<T> success(T data) {
        return CustomResponse.of(HttpStatus.OK, null, data);
    }

    public static <T> CustomResponse<T> success(String message) {
        return CustomResponse.of(HttpStatus.OK, message, null);
    }

    public static <T> CustomResponse<T> success() {
        return CustomResponse.of(HttpStatus.OK, null, null);
    }

    public static <T> CustomResponse<T> error(HttpStatus status, String message, T data) {
        return CustomResponse.of(status, message, data);
    }

    public static <T> CustomResponse<T> error(CustomErrorCode errorCode, T data) {
        return CustomResponse.of(errorCode.getHttpStatus(), errorCode.getMessage(), data);
    }

    public static <T> CustomResponse<T> error(CustomErrorCode errorCode) {
        return CustomResponse.of(errorCode.getHttpStatus(), errorCode.getMessage(), null);
    }

    public static <T> CustomResponse<T> error(CustomErrorCode errorCode, String message) {
        return CustomResponse.of(errorCode.getHttpStatus(), message, null);
    }
}