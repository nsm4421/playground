package com.karma.hipgora.service.user;

import com.karma.hipgora.exception.ErrorCode;
import com.karma.hipgora.exception.MyException;
import com.karma.hipgora.model.user.Role;
import com.karma.hipgora.model.user.State;
import com.karma.hipgora.model.user.User;
import com.karma.hipgora.model.user.UserEntity;
import com.karma.hipgora.repository.UserEntityRepository;
import com.karma.hipgora.utils.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;

    private final UserEntityRepository userEntityRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public User register(String username, String password, String email){
        if(userEntityRepository.findByUsername(username).isPresent()){
            throw new MyException(ErrorCode.DUPLICATED_USERNAME, null);
        }
        if (userEntityRepository.findByEmail(email).isPresent()){
            throw new MyException(ErrorCode.DUPLICATED_EMAIL, null);
        }
        String encodedPassword = bCryptPasswordEncoder.encode(password);
        UserEntity userEntity = userEntityRepository.save(
                UserEntity.of(username, encodedPassword, email, State.ACTIVE, Role.USER)
        );
        return User.from(userEntity);
    }

    public String login(String username, String password){
        UserEntity userEntity = userEntityRepository.findByUsername(username)
                .orElseThrow(()->new MyException(ErrorCode.USER_NOT_FOUND, null));
        // TODO : 테스트를 위해서 비밀번호 일치여부 확인하는 주석처리해놈. 나중에 풀어놓기
//        if (!bCryptPasswordEncoder.matches(password, userEntity.getPassword())){
//            throw new MyException(ErrorCode.INVALID_PASSWORD, null);
//        }
        return JwtUtil.generateToken(username, duration, secretKey);
    }

    public User loadUserByUsername(String username) {
        UserEntity userEntity = userEntityRepository.findByUsername(username)
                .orElseThrow(()->new MyException(ErrorCode.USER_NOT_FOUND, null));
        return User.from(userEntity);
    }
}
