package com.karma.myapp.controller.request;

import lombok.Data;

import java.util.Set;

@Data
public class ModifyArticleRequest {
    private Long articleId;
    private String title;
    private String content;
    private Set<String> hashtags;
}
