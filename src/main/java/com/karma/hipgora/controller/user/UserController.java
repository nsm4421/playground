package com.karma.hipgora.controller.user;

import com.karma.hipgora.controller.MyResponse;
import com.karma.hipgora.controller.requests.LoginRequest;
import com.karma.hipgora.controller.responses.LoginResponse;
import com.karma.hipgora.controller.requests.RegisterRequest;
import com.karma.hipgora.controller.responses.RegisterResponse;
import com.karma.hipgora.model.user.User;
import com.karma.hipgora.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public MyResponse<RegisterResponse> register(@RequestBody RegisterRequest registerRequest){
        String username = registerRequest.getUsername();
        String password = registerRequest.getPassword();
        String email = registerRequest.getEmail();
        User user = userService.register(username, password, email);
        RegisterResponse registerResponse = RegisterResponse.from(user);
        return MyResponse.success(registerResponse);
    }

    @PostMapping("/login")
    public MyResponse<LoginResponse> register(@RequestBody LoginRequest loginRequest){
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();
        String token = userService.login(username, password);
        return MyResponse.success(LoginResponse.of(username, token));
    }


}
