package com.karma.community.controller;

import com.karma.community.controller.request.ModifyArticleCommentRequest;
import com.karma.community.controller.request.SaveArticleCommentRequest;
import com.karma.community.model.dto.ArticleCommentDto;
import com.karma.community.model.security.CustomPrincipal;
import com.karma.community.model.util.CustomResponse;
import com.karma.community.service.ArticleCommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/comment")
public class ArticleCommentController {
    private final ArticleCommentService articleCommentService;

    @GetMapping("/{articleId}")
    public CustomResponse<Page<ArticleCommentDto>> getArticleComment(
            @PathVariable Long articleId,
            @PageableDefault Pageable pageable
    ){
        return CustomResponse.success(articleCommentService.findCommentsByArticleId(articleId, pageable));
    }

    @PostMapping
    public CustomResponse<Void> saveComment(
            @RequestBody SaveArticleCommentRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        articleCommentService.saveComment(req.toDto(principal.toDto()), principal.getUsername());
        return CustomResponse.success();
    }

    @PutMapping
    public CustomResponse<Void> modifyComment(
            @RequestBody ModifyArticleCommentRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        articleCommentService.modifyComment(req.getArticleCommentId(), req.getContent(), principal.getUsername());
        return CustomResponse.success();
    }

    @DeleteMapping("/{articleId}")
    public CustomResponse<Void> deleteComment(
            @PathVariable Long articleCommentId,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        articleCommentService.deleteComment(articleCommentId, principal.getUsername());
        return CustomResponse.success();
    }
}
