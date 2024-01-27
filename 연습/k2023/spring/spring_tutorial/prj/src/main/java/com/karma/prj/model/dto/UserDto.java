package com.karma.prj.model.dto;

import com.karma.prj.model.util.RoleType;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class UserDto {
    private String email;
    private String username;
    private String nickname;
    private String password;
    private RoleType role;
    private LocalDateTime createdAt;
    private LocalDateTime removedAt;

    private UserDto(String email, String username, String nickname, String password, RoleType role, LocalDateTime createdAt, LocalDateTime removedAt) {
        this.email = email;
        this.username = username;
        this.nickname = nickname;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
        this.removedAt = removedAt;
    }

    protected UserDto(){}

    public static UserDto of(String email, String username, String nickname, String password, RoleType role, LocalDateTime createdAt, LocalDateTime removedAt) {
        return new UserDto(email,username,nickname,password,role,createdAt,removedAt);
    }
}
