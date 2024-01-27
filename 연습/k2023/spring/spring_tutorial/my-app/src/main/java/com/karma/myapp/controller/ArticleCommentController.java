package com.karma.myapp.controller;

import com.karma.myapp.controller.request.ModifyCommentRequest;
import com.karma.myapp.controller.request.WriteCommentRequest;
import com.karma.myapp.controller.response.CustomResponse;
import com.karma.myapp.controller.response.GetCommentResponse;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.exception.CustomErrorCode;
import com.karma.myapp.exception.CustomException;
import com.karma.myapp.service.ArticleCommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/comment")
public class ArticleCommentController {
    private final ArticleCommentService articleCommentService;

    /**
     * 댓글 조회하기
     * @param articleId 게시글 id
     * @param parentCommentId 부모댓글 id
     * @param pageable
     * @return 댓글 page
     */
    @GetMapping
    public CustomResponse<Page<GetCommentResponse>> getCommentsByArticleId(
            @RequestParam(value = "article-id", required = false) Long articleId,
            @RequestParam(value = "parent-comment-id", required = false) Long parentCommentId,
            @PageableDefault Pageable pageable
    ) {
        if (articleId == null & parentCommentId == null){
            throw CustomException.of(CustomErrorCode.INVALID_PARAMETER, "both article id and parent comment id are null");
        }
        // 부모 댓글은 작성시간 내림차순, 자식 댓글은 작성시간 오름차순으로 정렬
        Pageable applyPageable = PageRequest.of(
                pageable.getPageNumber(),
                pageable.getPageSize(),
                parentCommentId == null
                        ? Sort.by("createdAt").descending()
                        : Sort.by("createdAt").ascending()
        );
        return CustomResponse.success(
                articleCommentService.getComments(articleId, parentCommentId, applyPageable)
                        .map(GetCommentResponse::from),
                "get comments success"
        );
    }

    /**
     * 댓글 작성하기
     * @param req 댓글 작성 요청
     * @param principal 로그인한 유저의 인증정보
     * @return 작성한 댓글
     */
    @PostMapping
    public CustomResponse<GetCommentResponse> writeComment(
            @RequestBody WriteCommentRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(
                GetCommentResponse.from(
                        articleCommentService.writeComment(
                                principal,
                                req.getArticleId(),
                                req.getParentCommentId(),
                                req.getContent()
                        )
                ),
                "write comment success");
    }

    /**
     * 댓글 수정하기
     * @param req 댓글 수정 요청
     * @param principal 로그인한 유저의 인증정보
     * @return 작성한 댓글
     */
    @PutMapping
    public CustomResponse<GetCommentResponse> modifyComment(
            @RequestBody ModifyCommentRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(
                GetCommentResponse.from(
                        articleCommentService.modifyComment(
                                principal,
                                req.getCommentId(),
                                req.getContent()
                        )
                ),
                "modify comment success");
    }

    /**
     * 댓글 삭제
     * @param commentId 댓글 id 
     * @param principal 로그인한 유저의 인증정보
     * @return void
     */
    @DeleteMapping("/{commentId}")
    public CustomResponse<Void> deleteComment(
            @PathVariable Long commentId,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        articleCommentService.deleteComment(principal, commentId);
        return CustomResponse.success(null, "delete comment success");
    }
}
