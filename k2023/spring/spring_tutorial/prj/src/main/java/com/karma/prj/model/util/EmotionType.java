package com.karma.prj.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EmotionType {
    NONE("없음", 0L),
    LIKE("좋아요", 1L),
    HATE("싫어요", 2L);
    private final String description;
    private final Long seq;

    public EmotionType getOpposite(){
        return switch (this){
            case NONE -> NONE;
            case LIKE -> HATE;
            case HATE -> LIKE;
        };
    }
}
