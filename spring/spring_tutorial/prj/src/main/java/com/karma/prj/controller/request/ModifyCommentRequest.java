package com.karma.prj.controller.request;

import lombok.Getter;

@Getter
public class ModifyCommentRequest {
    private Long postId;
    private Long commentId;
    private String content;
}
