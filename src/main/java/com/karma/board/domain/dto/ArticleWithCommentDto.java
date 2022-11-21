package com.karma.board.domain.dto;

import com.karma.board.domain.Comment;
import lombok.Getter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Set;

@Getter
public class ArticleWithCommentDto implements Serializable {
    private String title;
    private String content;
    private String hashtags;
    private UserAccountDto userAccountDto;
    private LocalDateTime createdAt;
    private String createdBy;
    private Set<CommentDto> comments;

    protected ArticleWithCommentDto(){}

    private ArticleWithCommentDto(String title, String content, String hashtags, UserAccountDto userAccountDto,
                                 LocalDateTime createdAt, String createdBy, Set<CommentDto> comments) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.userAccountDto = userAccountDto;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
        this.comments = comments;
    }

    public static ArticleWithCommentDto of(String title, String content, String hashtags, UserAccountDto userAccountDto,
                                           LocalDateTime createdAt, String createdBy, Set<CommentDto> comments){
        return new ArticleWithCommentDto(title, content, hashtags, userAccountDto, createdAt, createdBy, comments);
    }

    public static ArticleWithCommentDto from(ArticleDto articleDto, UserAccountDto userAccountDto, Set<CommentDto> comments){
        return new ArticleWithCommentDto(
                articleDto.getTitle(), articleDto.getContent(), articleDto.getHashtags(),
                userAccountDto, articleDto.getCreatedAt(), articleDto.getCreatedBy(), comments
        );
    }
}
