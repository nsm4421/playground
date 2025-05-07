package com.karma.board.controller.request;

import com.karma.board.domain.dto.CommentDto;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class WriteCommentRequest {
    private Long articleId;
    private String content;

    private WriteCommentRequest(Long articleId) {
        this.articleId = articleId;
    }
    protected WriteCommentRequest(){};

    public static WriteCommentRequest of(Long articleId, String content){
        return new WriteCommentRequest(articleId, content);
    }

    public static CommentDto to(WriteCommentRequest writeCommentRequest){
        return CommentDto.of(
                writeCommentRequest.getArticleId(),
                writeCommentRequest.getContent(),
                null,
                null
        );
    }
}
