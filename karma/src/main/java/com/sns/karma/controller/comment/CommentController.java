package com.sns.karma.controller.comment;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.controller.comment.request.WriteCommentRequest;
import com.sns.karma.controller.comment.response.GetCommentResponse;
import com.sns.karma.service.CommentService;
import com.sns.karma.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
public class CommentController {

    private final PostService postService;
    private final CommentService commentService;

    // 댓글 조회
    @GetMapping("/{postId}/comment")
    public CustomResponse<Page<GetCommentResponse>> getComment(@PathVariable Long postId, Pageable pageable){
        // 댓글 가져오기
        Page<GetCommentResponse> getCommentResponses = commentService.getComment(postId, pageable)
        // convert : Comment → GetCommentResponse
                .map(GetCommentResponse::fromDto);
        // Return
        return CustomResponse.success(getCommentResponses);
    }

    // 댓글작성
    @PostMapping("/{postId}/comment")
    public CustomResponse<Void> writeComment(@PathVariable Long postId,
                                             @RequestBody WriteCommentRequest writeCommentRequest,
                                             Authentication authentication){
        // 댓쓴이
        String username = authentication.getName();
        //  댓글
        String comment = writeCommentRequest.getComment();
        // 저장
        commentService.writeComment(postId, username, comment);
        return CustomResponse.success();
    }
}
