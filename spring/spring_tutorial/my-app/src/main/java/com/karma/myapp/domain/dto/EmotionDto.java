package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.constant.EmotionConst;
import com.karma.myapp.domain.entity.EmotionEntity;

import java.time.LocalDateTime;

public record EmotionDto(
        Long id,
        EmotionConst emotion,
        UserAccountDto user,
        ArticleDto article,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy,
        LocalDateTime removedAt
) {
    public static EmotionDto from(EmotionEntity entity) {
        return new EmotionDto(
                entity.getId(),
                entity.getEmotion(),
                UserAccountDto.from(entity.getUser()),
                ArticleDto.from(entity.getArticle()),
                entity.getCreatedAt(),
                entity.getCreatedBy(),
                entity.getModifiedAt(),
                entity.getModifiedBy(),
                entity.getRemovedAt()
        );
    }
}
