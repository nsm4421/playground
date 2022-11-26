package com.karma.meeting.model.entity;

import com.karma.meeting.model.enums.RoleType;
import com.karma.meeting.model.enums.Sex;
import com.karma.meeting.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Entity
@ToString
@Table(
        indexes = {
        @Index(columnList = "email", unique = true),
        @Index(columnList = "nickname", unique = true)
})
@EntityListeners(AuditingFields.class)
public class UserAccount extends AuditingFields{
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false, updatable = false, name = "username")
    private String username;
    @Column(unique = true, nullable = false) @Setter
    private String nickname;
    @Column(nullable = false) @Enumerated(EnumType.STRING) @Setter
    private Sex sex;
    @Setter
    private String password;
    @Setter
    private String email;
    @Column(nullable = false) @Enumerated(EnumType.STRING)
    private RoleType roleType = RoleType.USER;
    @Column(nullable = false) @Setter
    private String description;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @Column(nullable = false) @Setter
    private LocalDateTime birthAt;

    private UserAccount(String username, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDateTime birthAt) {
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

    public static UserAccount of(String username, String nickname, Sex sex, String password, String email, RoleType roleType, String description, LocalDateTime birthAt) {
        return new UserAccount(username, nickname, sex, password, email, roleType, description, birthAt);
    }

    public static UserAccount of(String username, String nickname, Sex sex, String password, String email, String description, LocalDateTime birthAt) {
        return new UserAccount(username, nickname, sex, password, email, RoleType.USER, description, birthAt);
    }
}
