package com.karma.meeting.controller;

import com.karma.meeting.model.dto.UserAccountDto;
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
        userAccountService.register(username, nickname, password, email, Sex.MALE, description, birthAt);
        return "redirect:auth/login";
    }

    /**
     * 로그인
     */
    @GetMapping("/login")
    public String login(){
        return "/auth/login/index";
    }
}
