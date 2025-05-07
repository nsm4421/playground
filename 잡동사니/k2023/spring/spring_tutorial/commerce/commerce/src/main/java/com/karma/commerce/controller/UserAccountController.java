package com.karma.commerce.controller;

import com.karma.commerce.controller.request.SignUpRequest;
import com.karma.commerce.domain.dto.UserAccountDto;
import com.karma.commerce.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserAccountController {
    private final UserAccountService userAccountService;

    @PostMapping("/signUp")
    public UserAccountDto signUp(@RequestBody SignUpRequest req){
        return userAccountService.signUp(req.getUsername(), req.getEmail(), req.getImgUrl());
    }
}
