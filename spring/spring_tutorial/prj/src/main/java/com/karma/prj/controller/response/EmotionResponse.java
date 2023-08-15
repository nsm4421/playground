package com.karma.prj.controller.response;

import lombok.Getter;

import java.util.Map;


@Getter
public class EmotionResponse {
    private Long likeCount;
    private Long hateCount;
    private String emotionType;

    private EmotionResponse(Long likeCount, Long hateCount, String emotionType) {
        this.likeCount = likeCount;
        this.hateCount = hateCount;
        this.emotionType = emotionType;
    }
    protected EmotionResponse(){}

    public static EmotionResponse of(Long likeCount, Long hateCount, String emotionType){
        return new EmotionResponse(likeCount, hateCount, emotionType);
    }

    public static EmotionResponse from(Map<String, Object> map){
        return EmotionResponse.of((Long) map.get("LIKE"), (Long) map.get("HATE"), map.get("EMOTION").toString());
    }
}
