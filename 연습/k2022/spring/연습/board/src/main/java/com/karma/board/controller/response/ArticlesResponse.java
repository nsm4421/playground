package com.karma.board.controller.response;

import com.karma.board.domain.dto.ArticleDto;
import com.karma.board.domain.dto.ArticleWithCommentDto;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ArticlesResponse {

    private Long id;
    private String title;
    private String author;
    private String hashtags;
    private LocalDateTime createdAt;

    private ArticlesResponse(Long id, String title, String author, String hashtags, LocalDateTime createdAt) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.hashtags = hashtags;
        this.createdAt = createdAt;
    }

    protected ArticlesResponse(){}

    public static ArticlesResponse of(Long id, String title, String author, String hashtags, LocalDateTime createdAt){
        return new ArticlesResponse(id, title, author, hashtags, createdAt);
    }

    public static ArticlesResponse from(ArticleDto dto){
        return ArticlesResponse.of(
                dto.getId(), dto.getTitle(), dto.getCreatedBy(), dto.getHashtags(), dto.getCreatedAt()
        );
    }
}
