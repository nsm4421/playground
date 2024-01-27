package com.karma.community.model.entity;

import com.karma.community.model.util.RoleType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@ToString(callSuper = true)
@Table(
        name = "user_account",
        indexes = {
                @Index(columnList = "nickname", unique = true),
                @Index(columnList = "email", unique = true),
                @Index(columnList = "createdAt")
})
@Entity
public class UserAccount {
    /** Fields
     * username : primary key
     * password : encoded password
     * nickname
     * description
     * roleType - 권한 설정을 위해 만듬
     * createdAt, modifiedAt - JPA Auditing 사용하지 않고, Service 코드에서 직접 박도록 설계
     */

    @Id @Column(length = 50, nullable = false)
    private String username;
    @Setter
    @Column(nullable = false)
    private String password;
    @Setter
    @Column(length = 100, unique = true)
    private String email;
    @Setter
    @Column(length = 100, unique = true,nullable = false)
    private String nickname;
    @Setter
    private String description;
    @Setter
    @Enumerated(EnumType.STRING)
    private RoleType roleType = RoleType.USER;

    @Setter
    private LocalDateTime createdAt;
    @Setter
    private LocalDateTime modifiedAt;
    @Setter
    private String createdBy;
    @Setter
    private String modifiedBy;

    protected UserAccount() {
    }

    private UserAccount(
            String username,
            String password,
            String email,
            String nickname,
            String description,
            RoleType roleType,
            LocalDateTime createdAt,
            String createdBy,
            LocalDateTime modifiedAt,
            String modifiedBy
    ) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.nickname = nickname;
        this.description = description;
        this.roleType = roleType;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
        this.modifiedAt = modifiedAt;
        this.modifiedBy = modifiedBy;
    }

    public static UserAccount of(String username, String password, String email, String nickname, String description, LocalDateTime createdAt, String createdBy, LocalDateTime modifiedAt, String modifiedBy) {
        return new UserAccount(username, password, email, nickname, description, RoleType.USER, createdAt, createdBy, modifiedAt, modifiedBy);
    }

    public static UserAccount of(String username, String password, String email, String nickname, String description) {
        return new UserAccount(username, password, email, nickname, description, RoleType.USER, null, null, null, null);
    }

    public static UserAccount of(String username, String password, String email, String nickname, String description, LocalDateTime createdAt, String createdBy) {
        return new UserAccount(username, password, email, nickname, description, RoleType.USER, createdAt, createdBy, createdAt, createdBy);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UserAccount that)) return false;
        return this.getUsername() != null && this.getUsername().equals(that.getUsername());
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getUsername());
    }
}