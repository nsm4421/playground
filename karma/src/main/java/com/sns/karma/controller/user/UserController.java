package com.sns.karma.controller.user;

import com.sns.karma.controller.Response;
import com.sns.karma.controller.user.request.UserRegisterRequest;
import com.sns.karma.controller.user.response.UserRegisterResponse;
import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.domain.user.UserRoleEnum;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.user.UserRepository;
import com.sns.karma.service.user.UserService;
import lombok.CustomLog;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {

    private final UserRepository userRepository;
    private final UserService userService;

    @PostMapping("/register")
    public Response<UserRegisterResponse> register(@RequestBody UserRegisterRequest userRegisterRequest){
        // Parsing Request
        String username = userRegisterRequest.getUsername();
        String password = userRegisterRequest.getPassword();
        OAuthProviderEnum provider = userRegisterRequest.getProvider();

        // 이미 존재하는 유저명 → Error
        userRepository.findByUsername(username)
                .ifPresent(it->{throw new CustomException(ErrorCodeEnum.DUPLICATED_USER_NAME, null);});

        // 회원가입 시도
        User user = userService.register(username, password, provider);

        // Response
        UserRegisterResponse userRegisterResponse = UserRegisterResponse.from(user);
        return Response.success(userRegisterResponse);
    }

    @PostMapping
    public void login(){
//        userService.register();
    }

}
