package com.karma.prj.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SearchType {
    NONE("검색사용 안함"),
    TITLE("포스팅 제목"),
    HASHTAG("단일 해쉬태그"),
    CONTENT("포스팅 본문"),
    NICKNAME("포스팅 작성자 닉네임");
    private String description;
}

