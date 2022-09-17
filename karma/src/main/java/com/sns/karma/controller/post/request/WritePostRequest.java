package com.sns.karma.controller.post.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class WritePostRequest {
    String title;
    String body;
}
