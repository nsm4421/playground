package com.karma.hipgora.controller.requests;

import lombok.Getter;

import java.util.Set;

@Getter
public class WritePostRequest {
    private String title;
    private String body;
    private Set<String> hashtags;
}
