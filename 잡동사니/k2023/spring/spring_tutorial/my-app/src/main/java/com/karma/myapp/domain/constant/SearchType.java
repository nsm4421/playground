package com.karma.myapp.domain.constant;

import lombok.Getter;

@Getter
public enum SearchType {
    /**
     * 게시글 검색 시 검색 유형
     */
    TITLE, CONTENT, HASHTAG, USER;
}
