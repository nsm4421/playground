package com.karma.prj.controller;

import com.karma.prj.controller.request.FollowRequest;
import com.karma.prj.controller.request.GetFollowerRequest;
import com.karma.prj.controller.request.LoginRequest;
import com.karma.prj.controller.request.RegisterRequest;
import com.karma.prj.controller.response.GetFollowerResponse;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.model.util.CustomResponse;
import com.karma.prj.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Set;
import java.util.stream.Collectors;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
public class UserController {
    private final UserService userService;
    /**
     * 회원가입
     * @Param - username nickname email password
     * @Return - nickname
     */
    @PostMapping("/register")
    public CustomResponse<String> register(@RequestBody RegisterRequest req){
        return CustomResponse.success(userService.register(req.getEmail(), req.getUsername(), req.getNickname(), req.getPassword()).getNickname());
    }
    /**
     * 로그인
     * @Param - username password
     * @Return - Authorization token (JWT)
     */
    @PostMapping("/login")
    public CustomResponse<String> login(@RequestBody LoginRequest req){
        return CustomResponse.success(userService.login(req.getUsername(), req.getPassword()));
    }

    /**
     * 닉네임 가져오기
     * @param authentication
     * @return 닉네임
     */
    @GetMapping("/nickname")
    public CustomResponse<String> getNickname(Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return CustomResponse.success(user.getNickname());
    }
    /**
     * 팔로잉하기
     */
    @PutMapping("/follow")
    public CustomResponse<Void> followUser(@RequestBody FollowRequest req, Authentication authentication){
        userService.followUser(req.getNickname(), (UserEntity) authentication.getPrincipal());
        return CustomResponse.success();
    }
    /**
     * 팔로워 리스트 가져오기
     * FollowingType = LEADER : 특정 유저를 팔로우하는 users
     * FollowingType = FOLLOWER : 특정 유저를 팔로잉하는 users
     * @return
     */
    @PostMapping("/follow")
    public CustomResponse<Set<GetFollowerResponse>> getFollowers(@RequestBody GetFollowerRequest req){
        return CustomResponse.success(
                userService.getUsersFollow(req.getNickname(), req.getFollowingType())
                        .stream()
                        .map(GetFollowerResponse::from).collect(Collectors.toSet())
        );
    }
    /**
     * 언팔로우
     */
    @DeleteMapping("/follow")
    public CustomResponse<Void> unfollow(
            @RequestBody FollowRequest req,
            Authentication authentication
    ){
        userService.unFollow(req.getNickname(), (UserEntity) authentication.getPrincipal());
        return CustomResponse.success();
    }
}
