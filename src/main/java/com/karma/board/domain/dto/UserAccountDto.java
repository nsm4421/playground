package com.karma.board.domain.dto;

import com.karma.board.domain.RoleType;
import lombok.Getter;

import java.io.Serializable;

@Getter
public class UserAccountDto implements Serializable {
    private String email;
    private String username;
    private String password;
    private String description;
    private RoleType roleType;

    private UserAccountDto(String email, String username, String password, String description, RoleType roleType) {
        this.email = email;
        this.username = username;
        this.password = password;
        this.description = description;
        this.roleType = roleType;
    }

    public static UserAccountDto of(String email, String username, String password, String description, RoleType roleType){
        return new UserAccountDto(email, username, password, description, roleType);
    }
}
