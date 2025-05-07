package com.karma.board.controller.response;

import com.karma.board.domain.dto.ArticleWithCommentDto;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ArticleResponse {
    private Long articleId;
    private String title;
    private String content;
    private String hashtags;
    private String author;
    private LocalDateTime createdAt;

    private ArticleResponse(Long articleId, String title, String content, String hashtags, String author, LocalDateTime createdAt) {
        this.articleId = articleId;
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.author = author;
        this.createdAt = createdAt;
    }

    protected ArticleResponse(){}

    public static ArticleResponse of(Long articleId, String title, String content, String hashtags, String author, LocalDateTime createdAt){
        return new ArticleResponse(articleId, title, content, hashtags, author, createdAt);
    }

    public static ArticleResponse from(ArticleWithCommentDto dto){
        String author = (dto.getCreatedBy()==null||dto.getCreatedBy().isBlank())
                ?dto.getUserAccountDto().getUsername()
                :dto.getCreatedBy();
        return ArticleResponse.of(dto.getArticleId(), dto.getTitle(), dto.getContent(), dto.getHashtags(), author, dto.getCreatedAt());
    }
}
