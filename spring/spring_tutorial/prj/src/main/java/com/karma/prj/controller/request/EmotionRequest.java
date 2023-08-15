package com.karma.prj.controller.request;

import com.karma.prj.model.util.EmotionActionType;
import com.karma.prj.model.util.EmotionType;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class EmotionRequest {
    private EmotionActionType emotionActionType;
    private EmotionType emotionType;
}
