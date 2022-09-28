package com.karma.hipgora.model.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class User {
    private String username;
    private String password;
    private String email;
    private State state = State.ACTIVE;
    private Role role;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static User of(String username, String password, String email, State state, Role role){
        return new User(username, password, email, state, role, null, null, null);
    }

    public static User from(UserEntity userEntity){
        return new User(
                userEntity.getUsername(),
                userEntity.getPassword(),
                userEntity.getEmail(),
                userEntity.getState(),
                userEntity.getRole(),
                userEntity.getRegisteredAt(),
                userEntity.getUpdatedAt(),
                userEntity.getRemovedAt());
    }
}
