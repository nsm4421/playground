package com.karma.board.domain.dto;

import com.karma.board.domain.Comment;

import java.time.LocalDateTime;

public class CommentDto {
    private String content;
    private LocalDateTime createdAt;
    private String createdBy;

    private CommentDto(String content, LocalDateTime createdAt, String createdBy) {
        this.content = content;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    private CommentDto(String content) {
        this.content = content;
        this.createdAt = null;
        this.createdBy = null;
    }

    protected CommentDto(){}

    public static CommentDto of(String content, LocalDateTime createdAt, String createdBy){
        return new CommentDto(content, createdAt, createdBy);
    }

    public static CommentDto of(String content){
        return new CommentDto(content);
    }

    public CommentDto from(Comment comment){
        return CommentDto.of(
                comment.getContent(),
                comment.getCreatedAt(),
                comment.getCreatedBy()
        );
    }
 }
