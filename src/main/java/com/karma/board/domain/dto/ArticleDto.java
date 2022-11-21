package com.karma.board.domain.dto;

import com.karma.board.domain.Article;

import java.io.Serializable;
import java.time.LocalDateTime;

public class ArticleDto implements Serializable {
    private String title;
    private String content;
    private String hashtags;
    private LocalDateTime createdAt;
    private String createdBy;

    protected ArticleDto(){}

    private ArticleDto(String title, String content, String hashtags, LocalDateTime createdAt, String createdBy) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    private ArticleDto(String title, String content, String hashtags) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.createdAt = null;
        this.createdBy = null;
    }

    public static ArticleDto of(String title, String content, String hashtags, LocalDateTime createdAt, String createdBy){
        return new ArticleDto(title, content, hashtags, createdAt, createdBy);
    }

    public static ArticleDto of(String title, String content, String hashtags){
        return new ArticleDto(title, content, hashtags);
    }

    // Entity → Dto
    public static ArticleDto from(Article article){
        return ArticleDto.of(
                article.getTitle(), article.getContent(), article.getHashtags(),
                article.getCreatedAt(), article.getCreatedBy()
        );
    }
}
