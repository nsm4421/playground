package com.sns.karma.service.user;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    private Boolean isExistUsername(String username){
        Optional<UserEntity> optionalUserEntity = userRepository.findByUsername(username);
        return optionalUserEntity.isPresent();
    }
    private UserEntity getUserEntityFromUsername(String username){
        UserEntity userEntity = userRepository
                .findByUsername(username)
                .orElseThrow(()->new CustomException(ErrorCodeEnum.USER_NOT_FOUND, null));
        return userEntity;
    }
    public User register(String username, String password, OAuthProviderEnum provider){
        // 이미 사용중인 유저명 확인
        if (isExistUsername(username)){
            throw new CustomException(ErrorCodeEnum.DUPLICATED_USER_NAME,
                    String.format("유저명 %s은 이미 사용중입니다.", username)
            );
        }
        // 유저정보 저장
        switch (provider){
            // Email, Password 회원가입
            case NONE:
                UserEntity userEntity = userRepository.save(UserEntity.of(username, password, OAuthProviderEnum.NONE));
                return User.from(userEntity);
            // TODO ; OAUTH
            case Google:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, "TODO");
            default:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, null);
        }
    }

    public String login(String username, String password, OAuthProviderEnum provider){

        // 이미 사용중인 유저명 확인
        if (!isExistUsername(username)){
            throw new CustomException(ErrorCodeEnum.DUPLICATED_USER_NAME,
                    String.format("유저명 %s은 존재하지 않는 회원입니다.", username)
            );
        }
        
        UserEntity userEntity = getUserEntityFromUsername(username);

        switch (provider){
            case NONE:
                User user = User.from(userEntity);
                // 비밀번호 일치여부 확인
                if(user.getPassword().equals(password)){
                    return "";
                }
                throw new CustomException(ErrorCodeEnum.INVALID_AUTH_INFO, null);
            // TODO
            case Google:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, "TODO");
            default:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, null);
        }
    }

}
