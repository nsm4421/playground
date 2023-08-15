package com.karma.myapp.controller.request;

import lombok.Data;

@Data
public class WriteCommentRequest {
    private Long articleId;
    private Long parentCommentId;
    private String content;
}
