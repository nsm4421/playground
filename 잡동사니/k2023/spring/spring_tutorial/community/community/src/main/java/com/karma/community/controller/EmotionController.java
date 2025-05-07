package com.karma.community.controller;

import com.karma.community.controller.request.AddEmotionRequest;
import com.karma.community.model.security.CustomPrincipal;
import com.karma.community.model.util.CustomResponse;
import com.karma.community.model.util.EmotionType;
import com.karma.community.service.EmotionService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/emotion")
@RequiredArgsConstructor
public class EmotionController {
    private final EmotionService emotionService;

    @GetMapping("/{articleId}")
    public CustomResponse<EmotionType> getEmotion(
            @PathVariable Long articleId,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        return CustomResponse.success(emotionService.getEmotion(articleId, principal.getUsername()));
    }

    @GetMapping("/count/{articleId}")
    public CustomResponse<Map<EmotionType, Long>> countEmotion(@PathVariable Long articleId){
        return CustomResponse.success(emotionService.countEmotion(articleId));
    }

    @PostMapping
    public CustomResponse<Void> addEmotion(
            @RequestBody AddEmotionRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        emotionService.addEmotion(req.getArticleId(), principal.getUsername(), req.getEmotionType());
        return CustomResponse.success();
    }

    @DeleteMapping("/{articleId}")
    public CustomResponse<Void> cancelEmotion(
            @PathVariable Long articleId,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        emotionService.cancelEmotion(articleId, principal.getUsername());
        return CustomResponse.success();
    }
}
