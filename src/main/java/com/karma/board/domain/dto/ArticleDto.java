package com.karma.board.domain.dto;

import com.karma.board.domain.Article;
import lombok.Getter;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
public class ArticleDto implements Serializable {
    private Long id;
    private String title;
    private String content;
    private String hashtags;
    private LocalDateTime createdAt;
    private String createdBy;

    protected ArticleDto(){}

    private ArticleDto(Long id, String title, String content, String hashtags, LocalDateTime createdAt, String createdBy) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    private ArticleDto(Long id, String title, String content, String hashtags) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.createdAt = null;
        this.createdBy = null;
    }

    public static ArticleDto of(Long id, String title, String content, String hashtags, LocalDateTime createdAt, String createdBy){
        return new ArticleDto(id, title, content, hashtags, createdAt, createdBy);
    }

    public static ArticleDto of(Long id, String title, String content, String hashtags){
        return new ArticleDto(id, title, content, hashtags);
    }

    // Entity → Dto
    public static ArticleDto from(Article article){
        return ArticleDto.of(
                article.getId(), article.getTitle(), article.getContent(), article.getHashtags(),
                article.getCreatedAt(), article.getCreatedBy()
        );
    }
}
