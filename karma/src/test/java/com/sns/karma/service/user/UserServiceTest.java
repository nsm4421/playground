package com.sns.karma.service.user;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.fixture.UserEntityFixture;
import com.sns.karma.repository.user.UserRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@SpringBootTest
class UserServiceTest {
    @Autowired UserService userService;
    @Autowired UserRepository userRepository;

    @Test
    @DisplayName("[회원가입]닉네임/비밀번호로 회원가입")
    void givenUsernameAndPassword_whenRegister_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userRepository.findByUsername(username))
                .thenReturn(Optional.empty());
        when(userRepository.save(any()))
                .thenReturn(Optional.of(mock(UserEntity.class)));

        Assertions.assertDoesNotThrow(()->userService.register(username,password,provider));
    }

    @Test
    @DisplayName("[회원가입]중복된 아이디로 회원가입")
    void givenUsernameAlreadyExists_whenRegister_thenThrowException() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;
        UserEntity userEntityFixture = UserEntityFixture.getUserEntityFixture(username, password);

        when(userRepository.findByUsername(username))
                .thenReturn(Optional.of(mock(UserEntity.class)));
        when(userRepository.save(any()))
                .thenReturn(Optional.of(userEntityFixture));

        Assertions.assertThrows(CustomException.class, ()->userService.register(username,password,provider));
    }

    @Test
    @DisplayName("[로그인]닉네임/비밀번호로 로그인")
    void givenUsernameAndPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        UserEntity userEntityFixture = UserEntityFixture.getUserEntityFixture(username, password);

        when(userRepository.findByUsername(username)).thenReturn(Optional.of(userEntityFixture));
        Assertions.assertThrows(CustomException.class, ()->userService.login(username,password,provider));
    }

    @Test
    @DisplayName("[로그인]회원가입 안된 유저명으로 로그인")
    void givenUsernameNotRegistered_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        when(userRepository.findByUsername(username)).thenReturn(Optional.empty());
        Assertions.assertThrows(CustomException.class, ()->userService.login(username,password,provider));
    }

    @Test
    @DisplayName("[로그인]잘못된 비밀번호로 로그인")
    void givenInvalidPassword_whenLogin_thenHandle() throws Exception {
        String username="test_username";
        String password="test_password";
        String wrongPassword="test_wrong_password";
        OAuthProviderEnum provider = OAuthProviderEnum.NONE;

        UserEntity userEntityFixture = UserEntityFixture.getUserEntityFixture(username, password);

        when(userRepository.findByUsername(username)).thenReturn(Optional.of(userEntityFixture));

        Assertions.assertThrows(CustomException.class, ()->userService.login(username,wrongPassword,provider));
    }



}