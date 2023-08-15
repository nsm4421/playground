package com.karma.community.controller.request;

import lombok.Data;

@Data
public class ModifyArticleCommentRequest {
    private Long articleCommentId;
    private String content;
}
