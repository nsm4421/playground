package com.karma.myapp.controller;


import com.karma.myapp.controller.request.EmotionRequest;
import com.karma.myapp.controller.response.CustomResponse;
import com.karma.myapp.domain.constant.EmotionConst;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.service.EmotionService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/emotion")
public class EmotionController {
    private final EmotionService emotionService;

    @GetMapping("/{articleId}")
    public CustomResponse<EmotionConst> getMyEmotion(
            @PathVariable Long articleId,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(emotionService.getMyEmotion(principal, articleId), "get emotion success");
    }

    @GetMapping
    public CustomResponse<Map<EmotionConst, Long>> getCountMap(@RequestParam(value = "article-id") Long articleId) {
        return CustomResponse.success(emotionService.getCountMap(articleId), "get count map success");
    }

    @PostMapping
    public CustomResponse<Void> handleEmotion(
            @AuthenticationPrincipal CustomPrincipal principal,
            @RequestBody EmotionRequest req
    ) {
        emotionService.handleEmotion(principal, req.getEmotion(), req.getArticleId());
        return CustomResponse.success(null, "handle emotion success");
    }
}
