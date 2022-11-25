package com.karma.board.controller;

import com.karma.board.controller.request.RegisterRequest;
import com.karma.board.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class MainController {

    private final UserAccountService userAccountService;

    @GetMapping("/")
    public String index(){
        return "redirect:/articles";
    }

    @GetMapping("/register")
    public String registerPage(){
        return "/auth/register/index";
    }

    @PostMapping("/register")
    public String register(RegisterRequest req){
        userAccountService.register(
                req.getEmail(),
                req.getUsername(),
                req.getPassword(),
                req.getDescription()
        );
        return "redirect:/login";
    }
}
