package com.sns.karma.domain.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Long id;
    private String username;
    private String password;
    private String email;
    private UserRoleEnum role;
    private OAuthProviderEnum provider;
    private UserStateEnum state;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp deletedAt;

    // Entity → DTO
    public static User from(UserEntity userEntity) {
        return new User(
                userEntity.getId(),
                userEntity.getUsername(),
                userEntity.getPassword(),
                userEntity.getEmail(),
                userEntity.getRole(),
                userEntity.getProvider(),
                userEntity.getState(),
                userEntity.getRegisteredAt(),
                userEntity.getUpdatedAt(),
                userEntity.getRemovedAt()
        );
    }
}
