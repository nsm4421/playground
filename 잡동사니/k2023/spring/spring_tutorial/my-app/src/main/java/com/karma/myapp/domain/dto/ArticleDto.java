package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.entity.ArticleEntity;

import java.time.LocalDateTime;
import java.util.Set;

public record ArticleDto(
        Long id,
        UserAccountDto user,
        String title,
        String content,
        Set<String> hashtags,
        String memo,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy
) {
    public static ArticleDto of(
            UserAccountDto user,
            String title,
            String content
    ) {
        return new ArticleDto(
                null,
                user,
                title,
                content,
                null,
                null,
                null,
                null,
                null,
                null
        );
    }

    public static ArticleDto from(ArticleEntity entity) {
        return new ArticleDto(
                entity.getId(),
                UserAccountDto.from(entity.getUser()),
                entity.getTitle(),
                entity.getContent(),
                entity.getHashtags(),
                entity.getMemo(),
                entity.getCreatedAt(),
                entity.getCreatedBy(),
                entity.getModifiedAt(),
                entity.getModifiedBy()
        );
    }
}