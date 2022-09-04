package com.sns.karma.service.user;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.user.UserRepository;
import com.sns.karma.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;

    public User register(String username, String password, String email, OAuthProviderEnum provider){
        // 이미 사용중인 유저명 확인
        userRepository
                .findByUsername(username)
                .ifPresent(it->{throw new CustomException(
                        ErrorCodeEnum.DUPLICATED_USER_NAME,
                        String.format("%s 는 이미 사용중인 유저명입니다", username));});

        // 이미 사용중인 이메일인지 확인
        userRepository
                .findByEmail(email)
                .ifPresent(it->{throw new CustomException(
                        ErrorCodeEnum.DUPLICATED_USER_NAME,
                        String.format("%s 는 이미 등록된 이메일입니다", email));});

        // 패스워드 Encoding
        String encodedPassword = passwordEncoder.encode(password);

        // 유저정보 저장
        switch (provider){
            // 회원가입
            case NONE:
                UserEntity userEntity = userRepository.save(UserEntity.of(username, encodedPassword, email, provider));
                return User.from(userEntity);
            // TODO ; OAUTH
            default:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, null);
        }
    }

    public String login(String username, String password, OAuthProviderEnum provider){

        // 이미 사용중인 유저명 확인
        UserEntity userEntity = userRepository
                .findByUsername(username)
                .orElseThrow(()->{throw new CustomException(
                        ErrorCodeEnum.USER_NOT_FOUND,
                        String.format("Username %s is not founded", username));});

        switch (provider){
            // 유저명 & Password 로그인
            case NONE:
                User user = User.from(userEntity);
                // 비밀번호 일치여부 확인
                if(!passwordEncoder.matches(password, user.getPassword())){
                    throw new CustomException(ErrorCodeEnum.INVALID_PASSWORD, null);
                }
                // 인증토큰 반환
                return JwtUtil.generateToken(username, secretKey, duration);
            // TODO
            default:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, null);
        }
    }

}
