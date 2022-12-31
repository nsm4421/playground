package com.karma.board.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SearchType {
    TITLE("Title"), CONTENT("Content"), USERNAME("Author"), HASHTAG("Hashtag");
    private String description;
}
