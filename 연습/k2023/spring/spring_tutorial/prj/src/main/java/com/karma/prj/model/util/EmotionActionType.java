package com.karma.prj.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EmotionActionType {
    NEW("새로운 좋아요/싫어요 요청"),
    SWITCH("좋아요→싫어요 or 싫어요→좋아요"),
    CANCEL("좋아요/싫어요 취소");
    private final String description;
}
