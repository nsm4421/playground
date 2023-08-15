package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.entity.ArticleCommentEntity;

import java.time.LocalDateTime;

public record ArticleCommentDto(
        Long id,
        ArticleDto article,
        UserAccountDto user,
        String content,
        Long parentCommentId,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy,
        LocalDateTime removedAt

) {
    // Entity → Dto
    public static ArticleCommentDto from(ArticleCommentEntity entity) {
        return new ArticleCommentDto(
                entity.getId(),
                ArticleDto.from(entity.getArticle()),
                UserAccountDto.from(entity.getUser()),
                entity.getContent(),
                entity.getParentCommentId(),
                entity.getCreatedAt(),
                entity.getCreatedBy(),
                entity.getModifiedAt(),
                entity.getModifiedBy(),
                entity.getRemovedAt()
        );
    }
}
