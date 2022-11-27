package com.karma.meeting.model.dto;

import com.karma.meeting.model.enums.RoleType;
import com.karma.meeting.model.enums.Sex;
import com.karma.meeting.model.entity.UserAccount;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class UserAccountDto {
    private String username;
    private String nickname;
    private Sex sex;
    private String password;
    private String email;
    private RoleType roleType;
    private String description;
    private LocalDate birthAt;

    private UserAccountDto(String userId, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDate birthAt) {
        this.username = userId;
        this.nickname = nickname;
        this.sex = sex;
        this.password = password;
        this.email = email;
        this.roleType = roleType;
        this.description = description;
        this.birthAt = birthAt;
    }

    protected UserAccountDto(){}

    public static UserAccountDto of(String userId, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDate birthAt){
        return new UserAccountDto(userId,nickname,sex,password,email,roleType,description,birthAt);
    }

    public static UserAccountDto from(UserAccount u){
        return UserAccountDto.of(u.getUsername(), u.getNickname(), u.getSex(), u.getPassword(), u.getEmail(), u.getRoleType(), u.getDescription(), u.getBirthAt());
    }
}
