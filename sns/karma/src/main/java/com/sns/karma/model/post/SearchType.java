package com.sns.karma.model.post;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SearchType {
    TITLE("title"),
    AUTHOR("author");
    private final String name;
}
