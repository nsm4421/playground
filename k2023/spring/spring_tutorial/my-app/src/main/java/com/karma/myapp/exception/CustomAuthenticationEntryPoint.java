package com.karma.myapp.exception;

import com.karma.myapp.controller.response.CustomResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;

public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(
            HttpServletRequest request,
            HttpServletResponse response,
            AuthenticationException authException
    ) throws IOException {
        response.setContentType("application/json");
        response.setStatus(CustomErrorCode.INVALID_TOKEN.getHttpStatus().value());
        response.getWriter().write(CustomResponse.error(CustomErrorCode.INVALID_TOKEN.name()).toJson());
    }
}
