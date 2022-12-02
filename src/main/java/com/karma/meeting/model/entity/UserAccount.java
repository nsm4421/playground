package com.karma.meeting.model.entity;

import com.karma.meeting.model.util.AuditingFields;
import com.karma.meeting.model.util.RoleType;
import com.karma.meeting.model.util.Sex;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Entity
@ToString
@Table(name = "user_account",
        indexes = {
                @Index(columnList = "email", unique = true),
                @Index(columnList = "nickname", unique = true),
                @Index(columnList = "username", unique = true)
})
@EntityListeners(AuditingEntityListener.class)
@SQLDelete(sql = "UPDATE user_account SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class UserAccount {
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

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate
    protected LocalDateTime createdAt;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @LastModifiedDate
    protected LocalDateTime modifiedAt;

    private LocalDateTime removedAt = null;

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
