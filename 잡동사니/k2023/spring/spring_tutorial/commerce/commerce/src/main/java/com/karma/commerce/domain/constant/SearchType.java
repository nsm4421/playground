package com.karma.commerce.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SearchType {
    NAME("상품이름"),
    DESCRIPTION("상품설명"),
    HASHTAG("해시태그");
    private final String description;
}
