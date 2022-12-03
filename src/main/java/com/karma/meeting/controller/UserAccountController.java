package com.karma.meeting.controller;

import com.karma.meeting.controller.request.RegisterRequest;
import com.karma.meeting.model.util.CustomPrincipal;
import com.karma.meeting.model.util.CustomResponse;
import com.karma.meeting.model.util.CustomState;
import com.karma.meeting.model.util.Sex;
import com.karma.meeting.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequiredArgsConstructor
public class UserAccountController {
    private final UserAccountService userAccountService;

    /**
     * Index페이지
     */
    @GetMapping("/")
    public String index(){
        return "/index";
    }

    /**
     * 회원가입
     */
    @GetMapping("/register")
    public String register(){
        return "/auth/register/index";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam("username") String username,
            @RequestParam("nickname") String nickname,
            @RequestParam("password") String password,
            @RequestParam("email") String email,
//            @RequestParam("sex") Sex sex,
            @RequestParam("description") String description,
            @RequestParam("birthAt") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate birthAt
    ){
        // TODO : 회원가입화면 수정하면
        //  1) @RequestParam("sex") 주석 해제
        //  2) sex.MALE → sex
        CustomResponse response = userAccountService.register(username, nickname, password, email, Sex.MALE, description, birthAt);
        return switch (response.getState()){
            case SUCCESS -> "/index";
            case DUPLICATED_ENTITY -> String.format("/register?error=%s",response.getMessage());
            default -> "/register?error=" + "알수 없는 에러...";
        };
    }

    /**
     * 로그인
     */
    @GetMapping("/login")
    public String login(){
        return "/auth/login/index";
    }
}
