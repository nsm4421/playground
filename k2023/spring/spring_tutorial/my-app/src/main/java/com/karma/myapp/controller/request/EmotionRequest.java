package com.karma.myapp.controller.request;

import com.karma.myapp.domain.constant.EmotionConst;
import lombok.Data;

@Data
public class EmotionRequest {
    private Long articleId;
    private EmotionConst emotion;
}
