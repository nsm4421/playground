package com.karma.prj.controller.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ModifyPostRequest {
    private Long postId;
    private String title;
    private String content;
    private String hashtags;
}
