package com.sns.karma.controller.feed.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class WriteFeedRequest {
    private String title;
    private String body;
}
