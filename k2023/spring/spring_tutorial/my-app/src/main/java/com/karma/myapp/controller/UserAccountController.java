package com.karma.myapp.controller;

import com.karma.myapp.controller.request.LoginRequest;
import com.karma.myapp.controller.request.ModifyUserInfoRequest;
import com.karma.myapp.controller.request.NewTokenRequest;
import com.karma.myapp.controller.request.SignUpRequest;
import com.karma.myapp.controller.response.CustomResponse;
import com.karma.myapp.controller.response.LoginResponse;
import com.karma.myapp.controller.response.SignUpResponse;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.domain.dto.UserAccountDto;
import com.karma.myapp.exception.CustomErrorCode;
import com.karma.myapp.exception.CustomException;
import com.karma.myapp.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserAccountController {
    private final UserAccountService userAccountService;

    // 회원가입
    @PostMapping("/signup")
    public CustomResponse<SignUpResponse> signUp(@RequestBody SignUpRequest req) {
        UserAccountDto dto = userAccountService.signUp(
                req.getUsername(),
                req.getEmail(),
                req.getPassword(),
                req.getMemo()
        );
        return CustomResponse.success(SignUpResponse.from(dto), "sign up success");
    }

    // 로그인
    @PostMapping("/login")
    public CustomResponse<LoginResponse> login(@RequestBody LoginRequest req) {
        String token = userAccountService.login(
                req.getUsername(),
                req.getPassword()
        );
        return CustomResponse.success(new LoginResponse(req.getUsername(), token), "login success");
    }

    @PostMapping("/token")
    public CustomResponse<LoginResponse> newToken(
            @RequestBody NewTokenRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        String username = principal.getUsername();
        if (req.getUsername().equals(username)){
            throw CustomException.of(CustomErrorCode.INVALID_TOKEN, "Username written in token and given username is not matced");
        }
        String newToken = userAccountService.generateToken("username", username);
        return CustomResponse.success(new LoginResponse(username, newToken), "new token");
    }

    @GetMapping("/username")
    public CustomResponse<String> getUsername(@AuthenticationPrincipal CustomPrincipal principal) {
        return CustomResponse.success(principal.getUsername());
    }

    // 회원정보 변경
    @PutMapping("/modify")
    public CustomResponse<SignUpResponse> modifyUserInfo(
            @RequestBody ModifyUserInfoRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(
                SignUpResponse.from(
                        userAccountService.modifyUserInfo(
                                principal,
                                req.getPassword(),
                                req.getEmail(),
                                req.getMemo())),
                "modify user information success");
    }
}