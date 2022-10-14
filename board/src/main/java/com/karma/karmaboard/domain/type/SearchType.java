package com.karma.karmaboard.domain.type;

import lombok.Getter;

@Getter
public enum SearchType {
    TITLE("Title"), CONTENT("Content"), ID("User ID"), HASHTAG("Hashtag");

    private final String description;

    SearchType(String description){
        this.description = description;
    }
}
