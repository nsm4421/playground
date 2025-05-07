package com.karma.prj.controller.request;

import lombok.Getter;

@Getter
public class CreateCommentRequest {
    private Long postId;
    private String content;
}
