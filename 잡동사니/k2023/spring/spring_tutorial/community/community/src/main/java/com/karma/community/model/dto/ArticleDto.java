package com.karma.community.model.dto;

import com.karma.community.model.entity.Article;
import com.karma.community.model.entity.UserAccount;

import java.time.LocalDateTime;
import java.util.Set;

public record ArticleDto(
        Long articleId,
        UserAccountDto userAccountDto,
        String title,
        String content,
        Set<String> hashtags,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy
) {
    public static ArticleDto of(
            Long articleId,
            UserAccountDto userAccountDto,
            String title,
            String content,
            Set<String> hashtags,
            LocalDateTime createdAt,
            String createdBy,
            LocalDateTime modifiedAt,
            String modifiedBy
    ) {
        return new ArticleDto(articleId, userAccountDto, title, content, hashtags, createdAt, createdBy, modifiedAt, modifiedBy);
    }

    public static ArticleDto of(
            UserAccountDto userAccountDto,
            String title,
            String content,
            Set<String> hashtags
    ) {
        return new ArticleDto(null, userAccountDto, title, content, hashtags, null, null, null, null);
    }

    /** Entity → DTO */
    public static ArticleDto from(Article article){
        return ArticleDto.of(
                article.getArticleId(),
                UserAccountDto.from(article.getUserAccount()),
                article.getTitle(),
                article.getContent(),
                article.getHashtags(),
                article.getCreatedAt(),
                article.getCreatedBy(),
                article.getModifiedAt(),
                article.getModifiedBy()
        );
    }

    /**
     * Compose Article Entity
     * @param userAccount entity
     * @param title 제목
     * @param content 게시글 본문
     * @param hashtags 해시태그
     * @return Article entity
     */
    public static Article toEntity(
            UserAccount userAccount,
            String title,
            String content,
            Set<String> hashtags
    ) {
        return Article.of(
                userAccount,
                title,
                content,
                hashtags
        );
    }
}
