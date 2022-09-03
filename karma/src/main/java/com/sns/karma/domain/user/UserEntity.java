package com.sns.karma.domain.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.Objects;


@Setter
@Getter
@Entity
@Table(name = "\"users\"",
        indexes = {@Index(columnList = "username"),@Index(columnList = "state")})
@SQLDelete(sql = "UPDATE \"users\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class UserEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "username", unique = true, nullable = false) private String username;
    @Column(name="password") private String password;
    @Column(name="email") private String email;
    @Enumerated(EnumType.STRING) private UserRoleEnum role = UserRoleEnum.USER;
    @Enumerated(EnumType.STRING) private OAuthProviderEnum provider = OAuthProviderEnum.NONE;
    @Enumerated(EnumType.STRING) @Column(name="state") private UserStateEnum state = UserStateEnum.ACTIVE;
    @Column(name = "registered_at") private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    @PrePersist void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }

    public static UserEntity of(String username, String password, OAuthProviderEnum provider) {
        UserEntity userEntity = new UserEntity();
        userEntity.setUsername(username);
        userEntity.setPassword(password);
        userEntity.setProvider(provider);
        return userEntity;
    }
}