package com.karma.myapp.controller.request;

import lombok.Data;

import java.util.Set;

@Data
public class WriteArticleRequest {
    private String title;
    private String content;
    private Set<String> hashtags;
}
