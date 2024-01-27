package com.karma.board.domain.dto;

import com.karma.board.domain.Comment;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CommentDto {
    private Long articleId;
    private String content;
    private LocalDateTime createdAt;
    private String createdBy;

    private CommentDto(Long articleId, String content, LocalDateTime createdAt, String createdBy) {
        this.articleId = articleId;
        this.content = content;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    protected CommentDto(){}

    public static CommentDto of(Long articleId, String content, LocalDateTime createdAt, String createdBy){
        return new CommentDto(articleId, content, createdAt, createdBy);
    }

    public static CommentDto from(Comment comment){
        return CommentDto.of(
                comment.getArticle().getId(),
                comment.getContent(),
                comment.getCreatedAt(),
                comment.getCreatedBy()
        );
    }
 }
