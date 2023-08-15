package com.karma.commerce.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Category {
    CLOTH("옷"),
    SHOES("신발"),
    ELECTRONICS("전자기기"),
    BOOK("책"),
    ETC("기타");
    private final String description;
}
