package com.karma.prj.controller.request;

import lombok.Getter;

@Getter
public class DeleteCommentRequest {
    private Long postId;
    private Long commentId;
}
