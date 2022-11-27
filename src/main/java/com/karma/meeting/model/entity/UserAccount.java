package com.karma.meeting.model.entity;

import com.karma.meeting.model.enums.RoleType;
import com.karma.meeting.model.enums.Sex;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Entity
@ToString
@Table(
        indexes = {
                @Index(columnList = "email", unique = true),
                @Index(columnList = "nickname", unique = true),
                @Index(columnList = "username", unique = true)
})
public class UserAccount{
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false, updatable = false, name = "username")
    private String username;
    @Column(unique = true, nullable = false) @Setter
    private String nickname;
    @Enumerated(EnumType.STRING) @Setter
    private Sex sex;
    @Setter
    private String password;
    @Setter
    private String email;
    @Column(nullable = false) @Enumerated(EnumType.STRING)
    private RoleType roleType = RoleType.USER;
    @Setter
    private String description;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) @Setter
    private LocalDate birthAt;

    private UserAccount(String username, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDate birthAt) {
        this.username = username;
        this.nickname = nickname;
        this.sex = sex;
        this.password = password;
        this.email = email;
        this.roleType = roleType;
        this.description = description;
        this.birthAt = birthAt;
    }

    protected UserAccount(){}

    public static UserAccount of(String username, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDate birthAt) {
        return new UserAccount(username, nickname, sex, password, email, roleType, description, birthAt);
    }

    public static UserAccount of(String username, String nickname, Sex sex, String password, String email, String description, LocalDate birthAt) {
        return new UserAccount(username, nickname, sex, password, email, RoleType.USER, description, birthAt);
    }
}
