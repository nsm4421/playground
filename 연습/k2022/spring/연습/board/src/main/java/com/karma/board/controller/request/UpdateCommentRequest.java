package com.karma.board.controller.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UpdateCommentRequest {
    private Long articleId;
    private Long commentId;
    private String content;
}
