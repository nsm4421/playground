package com.sns.karma.controller.user;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.model.user.Provider;
import com.sns.karma.model.user.User;
import com.sns.karma.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    // 이메일 회원가입
    @PostMapping("/register")
    public CustomResponse<UserRegisterResponse> register(@RequestBody UserRegisterRequest userRegisterRequest){
        // 회원가입 요청 parsing
        String email = userRegisterRequest.getEmail();
        String username = userRegisterRequest.getUsername();
        String password = userRegisterRequest.getPassword();

        // 회원가입
        User user = userService.register(email, username, password, Provider.EMAIL);

        // 응답 반환
        UserRegisterResponse userRegisterResponse = UserRegisterResponse.from(user);
        return CustomResponse.success(userRegisterResponse);
    }

    // 유저명 & 비밀번호 로그인
    @PostMapping("/login")
    public CustomResponse<UserLoginResponse>login(@RequestBody UserLoginRequest userLoginRequest){
        // 로그인 요청 parsing
        String username = userLoginRequest.getUsername();
        String password = userLoginRequest.getPassword();

        // 로그인
        String authToken = userService.login(username, password);
        
        // 응답 반환
        return CustomResponse.success(new UserLoginResponse(authToken));
    }

}
