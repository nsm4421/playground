package com.sns.karma.service.user;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public User getUser(String username){
        return userRepository
                .findByUsername(username)
                .map(User::from)
                .orElseThrow(()->new CustomException(
                        ErrorCodeEnum.USER_NOT_FOUND,
                        String.format("유저명 %s은 존재하지 않습니다", username)
                ));
    }

    private Boolean isValidUsername(String username){
        return !userRepository.findByUsername(username).isPresent();
    }

    private User register(String username, String password, OAuthProviderEnum provider){
        // 이미 사용중인 이메일인지 확인
        if (!isValidUsername(username)){
            throw new CustomException(ErrorCodeEnum.DUPLICATED_USER_NAME,
                    String.format("유저명 %s은 이미 사용중입니다", username)
            );
        }

        switch (provider){
            case NONE:
                UserEntity userEntity = userRepository.save(UserEntity.of(username, password, OAuthProviderEnum.NONE));
                return User.from(userEntity);
            case Google:    // TODO
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, "TODO");
            default:
                throw new CustomException(ErrorCodeEnum.INVALID_PROVIDER, null);
        }
    }

}
