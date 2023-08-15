package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.constant.UserRole;
import com.karma.myapp.domain.constant.UserStatus;
import com.karma.myapp.domain.entity.UserAccountEntity;

import java.time.LocalDateTime;

public record UserAccountDto (
        Long id,
        String username,
        String email,
        String password,
        UserRole userRole,
        UserStatus userStatus,
        String memo,
        LocalDateTime createdAt,
        LocalDateTime modifiedAt,
        LocalDateTime removedAt
){
    public static UserAccountDto of(String username, String email, String password, String memo) {
        return new UserAccountDto(
                null,
                username,
                email,
                password,
                UserRole.USER,
                UserStatus.ACTIVE,
                memo,
                null,
                null,
                null
        );
    }

    // entity → dto
    public static UserAccountDto from(UserAccountEntity entity){
        return new UserAccountDto(
                entity.getId(),
                entity.getUsername(),
                entity.getEmail(),
                entity.getPassword(),
                entity.getUserRole(),
                entity.getUserStatus(),
                entity.getMemo(),
                entity.getCreatedAt(),
                entity.getModifiedAt(),
                entity.getRemovedAt()
        );
    }
}
