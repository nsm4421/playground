package com.sns.karma.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sns.karma.controller.user.request.UserLoginRequest;
import com.sns.karma.controller.user.request.UserRegisterRequest;
import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.service.user.UserService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
public class UserControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @MockBean
    private UserService userService;

    @Test
    @DisplayName("[회원가입]닉네임/비밀번호로 회원가입")
    void givenUsernameAndPassword_whenRegister_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userService.register(username, password, provider)).thenReturn(mock(User.class));

        mockMvc.perform(
                post("api/vi/user/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsBytes(new UserRegisterRequest(username, password, provider))))
                .andDo(print())
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("[회원가입]중복된 아이디로 회원가입")
    void givenUsernameAlreadyExists_whenRegister_thenThrowException() throws Exception{
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userService.register(username, password, provider))
                .thenThrow(new CustomException(ErrorCodeEnum.DUPLICATED_USER_NAME, null));

        mockMvc.perform(
                        post("api/vi/user/register")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsBytes(new UserRegisterRequest(username, password, OAuthProviderEnum.NONE))))
                .andDo(print())
                .andExpect(status().isConflict());
    }

    @Test
    @DisplayName("[로그인]닉네임/비밀번호로 로그인")
    void givenUsernameAndPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userService.login(username, password, provider)).thenReturn("test_token");

        mockMvc.perform(
                        post("api/vi/user/login")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsBytes(new UserLoginRequest(username, password, provider))))
                .andDo(print())
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("[로그인]회원가입 안된 유저명으로 로그인")
    void givenUsernameNotRegistered_whenLogin_thenHandle() throws Exception {
        String username="test_username_not_registered";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userService.login(username, password, provider))
                .thenThrow(new CustomException(ErrorCodeEnum.USER_NOT_FOUND, null));

        mockMvc.perform(
                        post("api/vi/user/login")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsBytes(new UserLoginRequest(username, password, provider))))
                .andDo(print())
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("[로그인]잘못된 비밀번호로 로그인")
    void givenInvalidPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_wrong_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userService.login(username, password, provider))
                .thenThrow(new CustomException(ErrorCodeEnum.INVALID_AUTH_INFO, null));

        mockMvc.perform(
                        post("api/vi/user/login")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsBytes(new UserLoginRequest(username, password, provider))))
                .andDo(print())
                .andExpect(status().isUnauthorized());
    }

}
