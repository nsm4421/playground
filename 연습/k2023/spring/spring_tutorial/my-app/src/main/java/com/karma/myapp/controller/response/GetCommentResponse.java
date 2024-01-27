package com.karma.myapp.controller.response;

import com.karma.myapp.domain.dto.ArticleCommentDto;

import java.time.LocalDateTime;

public record GetCommentResponse(
        Long id,
        Long articleId,
        String username,
        String content,
        Long parentCommentId,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy
) {

    // dto → response
    public static GetCommentResponse from(ArticleCommentDto dto) {
        return new GetCommentResponse(
                dto.id(),
                dto.article().id(),
                dto.user().username(),
                dto.content(),
                dto.parentCommentId(),
                dto.createdAt(),
                dto.createdBy(),
                dto.modifiedAt(),
                dto.modifiedBy()
        );
    }
}
