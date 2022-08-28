package com.sns.karma.domain.user;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;


@Getter
@AllArgsConstructor
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
    public static User from(UserEntity e) {
        return new User(
                e.getId(),
                e.getUsername(),
                e.getPassword(),
                e.getEmail(),
                e.getRole(),
                e.getProvider(),
                e.getState(),
                e.getRegisteredAt(),
                e.getUpdatedAt(),
                e.getDeletedAt()
        );
    }
}
