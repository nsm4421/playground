package com.sns.karma.controller.user;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.controller.user.response.GetNotificationResponse;
import com.sns.karma.controller.user.request.IsExistEmailRequest;
import com.sns.karma.controller.user.request.IsExistUsernameRequest;
import com.sns.karma.controller.user.request.UserLoginRequest;
import com.sns.karma.controller.user.request.UserRegisterRequest;
import com.sns.karma.controller.user.response.UserLoginResponse;
import com.sns.karma.controller.user.response.UserRegisterResponse;
import com.sns.karma.model.notification.Notification;
import com.sns.karma.model.user.Provider;
import com.sns.karma.model.user.User;
import com.sns.karma.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    // 유저명 중복여부
    @PostMapping("/check/is-exist-username")
    public CustomResponse<Boolean> isExistUsername(@RequestBody IsExistUsernameRequest isExistUsernameRequest){
        String username = isExistUsernameRequest.getUsername();
        Boolean bool = userService.isExistUsername(username);
        return CustomResponse.success(bool);
    }

    // 이메일 중복여부
    @PostMapping("/check/is-exist-email")
    public CustomResponse<Boolean> isExistEmail(@RequestBody IsExistEmailRequest isExistEmailRequest){
        String email = isExistEmailRequest.getEmail();
        Boolean bool = userService.isExistEmail(email);
        return CustomResponse.success(bool);
    }

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
        return CustomResponse.success(new UserLoginResponse(username, authToken));
    }

    // 알림 가져오기
    @GetMapping("/notification")
    public CustomResponse<Page<GetNotificationResponse>> getNotification(
            Pageable pageable, Authentication authentication){
        String username = authentication.getName();
        Page<GetNotificationResponse> getNotificationResponses = userService
                .getNotification(username, pageable)
                .map(GetNotificationResponse::fromDto);
        return CustomResponse.success(getNotificationResponses);
    }
}
