package com.karma.community.model.dto;

import com.karma.community.model.entity.Article;
import com.karma.community.model.entity.ArticleComment;
import com.karma.community.model.entity.UserAccount;

import java.time.LocalDateTime;

public record ArticleCommentDto(
        Long articleCommentId,
        Long articleId,
        UserAccountDto userAccountDto,
        Long parentCommentId,
        String content,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy
) {

    public static ArticleCommentDto of(
            Long articleCommentId,
            Long articleId,
            UserAccountDto userAccountDto,
            Long parentCommentId,
            String content,
            LocalDateTime createdAt,
            String createdBy,
            LocalDateTime modifiedAt,
            String modifiedBy
    ) {
        return new ArticleCommentDto(
                articleCommentId,
                articleId,
                userAccountDto,
                parentCommentId,
                content,
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy
        );
    }

    public static ArticleCommentDto of(
            Long articleId,
            UserAccountDto userAccountDto,
            String content
    ) {
        return ArticleCommentDto.of(
                null,
                articleId,
                userAccountDto,
                null,
                content,
                null,
                null,
                null,
                null
        );
    }

    public static ArticleCommentDto of(
            Long articleId,
            UserAccountDto userAccountDto,
            Long parentCommentId,
            String content
    ) {
        return ArticleCommentDto.of(
                null,
                articleId,
                userAccountDto,
                parentCommentId,
                content,
                null,
                null,
                null,
                null
        );
    }

    /**
     * Entity → DTO
     * @param articleComment Entity
     * @return DTO
     */
    public static ArticleCommentDto from(ArticleComment articleComment) {
        return ArticleCommentDto.of(
                articleComment.getArticleCommentId(),
                articleComment.getArticle().getArticleId(),
                UserAccountDto.from(articleComment.getUserAccount()),
                articleComment.getParentCommentId(),
                articleComment.getContent(),
                articleComment.getCreatedAt(),
                articleComment.getCreatedBy(),
                articleComment.getModifiedAt(),
                articleComment.getModifiedBy()
        );
    }

    /**
     * DTO → Entity
     * @param article article entity
     * @param userAccount user entity
     * @param content 댓글내용
     * @return comment entity
     */
    public static ArticleComment toEntity(
            Article article,
            UserAccount userAccount,
            String content
    ) {
        return ArticleComment.of(
                article,
                userAccount,
                content
        );
    }
}
