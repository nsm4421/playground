package com.sns.karma.service.user;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.exception.CustomException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.transaction.Transactional;

@SpringBootTest
@Transactional
class UserServiceTest {
    @Autowired UserService userService;

    @Test
    @DisplayName("[회원가입]닉네임/비밀번호로 회원가입")
    void givenUsernameAndPassword_whenRegister_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        String email="test_email";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        // 회원가입
        Assertions.assertDoesNotThrow(()->userService.register(username,password,email,provider));
    }

    @Test
    @DisplayName("[회원가입]중복된 아이디로 회원가입")
    void givenUsernameAlreadyExists_whenRegister_thenThrowException() throws Exception {
        String username="test_username";
        String password="test_password";
        String email="test_email";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        // 회원가입
        Assertions.assertDoesNotThrow(()->userService.register(username,password,email,provider));
        // 동일한 정보로 회원가입
        Assertions.assertThrows(CustomException.class, ()->userService.register(username,password,email,provider));
    }

    @Test
    @DisplayName("[로그인]닉네임/비밀번호로 로그인")
    void givenUsernameAndPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        String email="test_email";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        // 회원가입
        Assertions.assertDoesNotThrow(()->userService.register(username,password,email,provider));
        // 로그인
        Assertions.assertDoesNotThrow(()->userService.login(username,password,provider));
    }

    @Test
    @DisplayName("[로그인]회원가입 안된 유저명으로 로그인")
    void givenUsernameNotRegistered_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        // 로그인
        Assertions.assertThrows(CustomException.class, ()->userService.login(username,password,provider));
    }

    @Test
    @DisplayName("[로그인]잘못된 비밀번호로 로그인")
    void givenInvalidPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        String email="test_email";
        String wrongPassword="test_wrong_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        // 회원가입
        Assertions.assertDoesNotThrow(()->userService.register(username,password,email,provider));
        // 잘못된 비밀번호로 로그인
        Assertions.assertThrows(CustomException.class, ()->userService.login(username,wrongPassword,provider));
    }
}