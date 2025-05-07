package com.karma.community.controller.request;

import com.karma.community.model.util.EmotionType;
import lombok.Data;

@Data
public class AddEmotionRequest {
    private Long articleId;
    private EmotionType emotionType;
}
