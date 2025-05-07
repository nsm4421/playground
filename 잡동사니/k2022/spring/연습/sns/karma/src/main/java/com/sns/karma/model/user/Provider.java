package com.sns.karma.model.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum Provider {
    EMAIL("이메일"),
    GOOGLE("구글계정"),
    NAVER("네이버");

    final String name;
}
