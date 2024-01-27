package com.karma.prj.util;

import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.model.util.CustomResponse;
import jakarta.servlet.ServletException;
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
            AuthenticationException authenticationException) throws IOException, ServletException
    {
        response.setContentType("application/json");
        response.setStatus(CustomErrorCode.INVALID_TOKEN.getStatus().value());
        response.getWriter().write(CustomResponse.json(CustomResponse.error(CustomErrorCode.INVALID_TOKEN.name())));
    }
}
