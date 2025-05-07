package com.karma.community.controller;

import com.karma.community.controller.request.RegisterRequest;
import com.karma.community.model.security.CustomPrincipal;
import com.karma.community.model.dto.UserAccountDto;
import com.karma.community.model.util.CustomResponse;
import com.karma.community.service.UserAccountService;
import lombok.RequiredArgsConstructor;;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserAccountController {
    private final UserAccountService userAccountService;

    // 현재 로그인한 유저명
    @GetMapping
    public String nickname(
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        return principal.nickname();
    }

    @GetMapping("/kakao/me")
    public String getUserInfo(@RequestParam("code") String code){
        return userAccountService.getUserInfoByAccessToken(
                userAccountService.getAccessTokenByAuthToken(code).access_token()
        );
    }

    @PostMapping("/register")
    public CustomResponse<String> register(@RequestBody RegisterRequest req){
        UserAccountDto dto = userAccountService.register(
                req.getUsername(),
                req.getPassword(),
                req.getEmail(),
                req.getNickname(),
                req.getDescription()
        );
        return CustomResponse.success(String.format("%s님 가입을 환영합니다.", dto.nickname()));
    }
}
