package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.Comment;

import java.time.LocalDateTime;

public class CommentDto {

    private String content;
    private Long feedId;
    private LocalDateTime createdAt;
    private String createdBy;

    private CommentDto(String content, Long feedId, LocalDateTime createdAt, String createdBy) {
        this.content = content;
        this.feedId = feedId;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    public CommentDto (){}

    public static CommentDto of(String content, Long feedId, LocalDateTime createdAt, String createdBy){
        return new CommentDto(content,feedId,createdAt,createdBy);
    }

    public static CommentDto from(Comment comment){
        return CommentDto.of(
                comment.getContent(),
                comment.getFeed().getId(),
                comment.getCreatedAt(),
                comment.getCreatedBy()
        );
    }
}
