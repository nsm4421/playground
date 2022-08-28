package com.sns.karma.domain.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name="users",
        indexes = {
        @Index(columnList = "username")
})
@NoArgsConstructor
public class UserEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="username", unique = true, nullable = false)
    private String username;

    @Column
    private String password;

    @Column(unique = true)
    private String email;

    @Column
    @Enumerated(EnumType.STRING)
    private UserRoleEnum role = UserRoleEnum.USER;

    @Column
    @Enumerated(EnumType.STRING)
    private OAuthProviderEnum provider = OAuthProviderEnum.NONE;

    @Column
    @Enumerated(EnumType.STRING)
    private UserStateEnum state = UserStateEnum.ACTIVE;

    @Column
    private Timestamp registeredAt;
    @Column
    private Timestamp updatedAt;
    @Column
    private Timestamp deletedAt;

    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }

    // DTO → Entity
    public static UserEntity of(String username, String encodedPwd) {
        UserEntity userEntity = new UserEntity();
        userEntity.setUsername(username);
        userEntity.setPassword(encodedPwd);
        return userEntity;
    }
}
