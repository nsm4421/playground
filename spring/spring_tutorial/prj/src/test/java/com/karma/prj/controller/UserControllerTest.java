package com.karma.prj.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.karma.prj.config.SecurityConfig;
import com.karma.prj.controller.request.LoginRequest;
import com.karma.prj.controller.request.RegisterRequest;
import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.exception.CustomException;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.service.UserService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@DisplayName("[UserController]")
@SpringBootTest
@AutoConfigureMockMvc
class UserControllerTest {
    @Autowired private MockMvc mockmvc;
    @MockBean private UserService userService;
    @Autowired private ObjectMapper objectMapper;

    @Test
    @DisplayName("[Register]Success sign up")
    @WithAnonymousUser
    public void 회원가입_정상동작() throws Exception {
        String username = "테스트용 유저명";
        String email = "테스트용 이메일";
        String nickname = "테스트용 닉네임";
        String password = "테스트용 비밀번호";

        when(userService.register(email, username, nickname, password)).thenReturn(mock(UserDto.class));

        mockmvc.perform(post("/api/v1/user/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsBytes(new RegisterRequest(email, username, nickname, password))))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("[Register]Fail sign up since duplicated")
    @WithAnonymousUser
    public void 중복된_이메일() throws Exception {
        String username = "테스트용 유저명";
        String email = "테스트용 이메일";
        String nickname = "테스트용 닉네임";
        String password = "테스트용 비밀번호";

        when(userService.register(email, username, nickname, password)).thenThrow(CustomException.of(CustomErrorCode.DUPLICATED_EMAIL));

        mockmvc.perform(post("/api/v1/user/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsBytes(new RegisterRequest(email, username, nickname, password))))
                .andExpect(status().is(CustomErrorCode.DUPLICATED_USERNAME.getStatus().value()));
    }


    @Test
    @DisplayName("[Login]Success Login")
    @WithAnonymousUser
    public void 로그인_성공() throws Exception {
        String username = "테스트용 유저명";
        String email = "테스트용 이메일";
        String nickname = "테스트용 닉네임";
        String password = "테스트용 비밀번호";
        userService.register(email, username, nickname, password);

        mockmvc.perform(post("/api/v1/user/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsBytes(new LoginRequest(username, password))))
                .andExpect(status().isOk());
    }
}