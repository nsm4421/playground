package com.karma.myapp.controller.request;

import lombok.Data;

@Data
public class ModifyCommentRequest {
    private Long commentId;
    private String content;
}
