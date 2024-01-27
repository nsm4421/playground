package com.karma.commerce.domain.dto;

import com.karma.commerce.domain.constant.UserRole;
import com.karma.commerce.domain.constant.UserStatus;
import com.karma.commerce.domain.entity.UserAccountEntity;

import java.time.LocalDateTime;

public record UserAccountDto(
        Long id,
        String username,
        String email,
        String imgUrl,
        String password,
        UserRole userRole,
        UserStatus userStatus,
        LocalDateTime createdAt,
        LocalDateTime modifiedAt,
        LocalDateTime removedAt
) {
    public static UserAccountDto of(
            String username,
            String email,
            String imgUrl,
            String password,
            UserRole userRole,
            UserStatus userStatus
    ) {
        return new UserAccountDto(
                null,
                username,
                email,
                imgUrl,
                password,
                userRole,
                userStatus,
                null,
                null,
                null
        );
    }

    public static UserAccountDto from(UserAccountEntity entity) {
        return new UserAccountDto(
                entity.getId(),
                entity.getUsername(),
                entity.getEmail(),
                entity.getImgUrl(),
                entity.getPassword(),
                entity.getUserRole(),
                entity.getUserStatus(),
                entity.getCreatedAt(),
                entity.getModifiedAt(),
                entity.getRemovedAt()
        );
    }
}
