package com.karma.prj.model.dto;

import com.karma.prj.model.util.EmotionType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmotionDto {
    private String username;
    private Long postId;
    private EmotionType emotionType;

    private EmotionDto(String username, Long postId, EmotionType emotionType) {
        this.username = username;
        this.postId = postId;
        this.emotionType = emotionType;
    }

    protected EmotionDto(){}

    public static EmotionDto of(String username, Long postId, EmotionType emotionType) {
        return new EmotionDto(username, postId, emotionType);
    }
}
