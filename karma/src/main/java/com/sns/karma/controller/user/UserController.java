package com.sns.karma.controller.user;

import com.sns.karma.controller.Response;
import com.sns.karma.controller.user.request.UserLoginRequest;
import com.sns.karma.controller.user.request.UserRegisterRequest;
import com.sns.karma.controller.user.response.UserLoginResponse;
import com.sns.karma.controller.user.response.UserRegisterResponse;
import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.User;
import com.sns.karma.repository.user.UserRepository;
import com.sns.karma.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
     private final UserService userService;

    @PostMapping("/register")
    public Response<UserRegisterResponse> register(@RequestBody UserRegisterRequest userRegisterRequest){
        // Parsing Request
        String username = userRegisterRequest.getUsername();
        String password = userRegisterRequest.getPassword();
        String email = userRegisterRequest.getEmail();
        OAuthProviderEnum provider = userRegisterRequest.getProvider();

        // 회원가입 시도
        User user = userService.register(username, password, email, provider);

        // Response
        UserRegisterResponse userRegisterResponse = UserRegisterResponse.from(user);
        return Response.success(userRegisterResponse);
    }

    @PostMapping("/login")
    public Response<UserLoginResponse> login(@RequestBody UserLoginRequest userLoginRequest){
        // Parsing Request
        String username = userLoginRequest.getUsername();
        String password = userLoginRequest.getPassword();
        OAuthProviderEnum provider = userLoginRequest.getProvider();

        // 인증토큰 반환
        String token = userService.login(username, password, provider);
        return Response.success(new UserLoginResponse(token));
    }
}
