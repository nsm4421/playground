package com.sns.karma.service;

import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCode;
import com.sns.karma.model.like.LikeEntity;
import com.sns.karma.model.notification.Notification;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.Provider;
import com.sns.karma.model.user.User;
import com.sns.karma.model.user.UserEntity;
import com.sns.karma.repository.NotificationEntityRepository;
import com.sns.karma.repository.PostEntityRepository;
import com.sns.karma.repository.UserEntityRepository;
import com.sns.karma.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserEntityRepository userEntityRepository;
    private final NotificationEntityRepository notificationEntityRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;  // password encoder


    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;


    // 유저명 중복여부
    public boolean isExistUsername(String username){ return userEntityRepository.findByUserName(username).isPresent();}
    // 이메일 중복여부
    public boolean isExistEmail(String email){
        return userEntityRepository.findByUserName(email).isPresent();
    }

    // 이메일 회원가입
    public User register(String email, String username, String password, Provider provider){
        // 이미 사용중인 유저명 확인
        if (isExistUsername(username)){
            throw new CustomException(
                    ErrorCode.DUPLICATED_USER_NAME,
                    String.format("username %s is already exists")
            );
        }
        // 이미 사용중인 이메일인지 확인
        if (isExistEmail(email)){
            throw new CustomException(
                    ErrorCode.DUPLICATED_EMAIL,
                    String.format("Email %s is already exists")
            );
        }
        // 패스워드 Encoding
        String encodedPassword = bCryptPasswordEncoder.encode(password);
        // 유저정보 저장
        UserEntity userEntity = userEntityRepository.save(UserEntity.of(email, username, encodedPassword,provider));
        // return (Entity → DTO)
        return User.fromEntity(userEntity);
    }

    // 유저명&비밀번호 로그인
    public String login(String username, String password){
        // 존재하는 유저인지 확인
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(username);

        // 비밀번호 일치 확인
        if (!bCryptPasswordEncoder.matches(password, userEntity.getPassword())){
            throw new CustomException(ErrorCode.INVALID_PASSWORD, null);
        }

        // 인증 토큰 발급
        return JwtUtil.generateAccessToken(username, secretKey, duration);
    }

    // 알림 가져오기
    public Page<Notification> getNotification(String username, Pageable pageable){
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(username);
        return notificationEntityRepository
                .findAllByUser(userEntity, pageable)
                .map(Notification::fromEntity);
    }

    public User loadUserByUsername(String username){
        return userEntityRepository.findByUserName(username).map(User::fromEntity)
                .orElseThrow(()->{throw new CustomException(ErrorCode.USER_NOT_FOUND, null);});
    }

    // 존재하는 유저명인지 확인
    private UserEntity ifExistUserNameThenUserEntityElseError(String username){
        return userEntityRepository.findByUserName(username)
                .orElseThrow(()->new CustomException(ErrorCode.USER_NOT_FOUND, null));
    }

    // 존재하는 이메일인지 확인
    private UserEntity ifExistEmailThenUserEntityElseError(String email){
        return userEntityRepository.findByEmail(email)
                .orElseThrow(()->new CustomException(ErrorCode.USER_NOT_FOUND, null));
    }
}
