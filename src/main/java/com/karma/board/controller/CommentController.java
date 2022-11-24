package com.karma.board.controller;

import com.karma.board.controller.request.DeleteCommentRequest;
import com.karma.board.controller.request.UpdateCommentRequest;
import com.karma.board.controller.request.WriteCommentRequest;
import com.karma.board.domain.RoleType;
import com.karma.board.domain.dto.CommentDto;
import com.karma.board.domain.dto.UserAccountDto;
import com.karma.board.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/comments")
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @PostMapping("/write")
    public String saveComment(WriteCommentRequest writeCommentRequest){
        // TODO : 인증기능 구현 후에 createdBy는 실제 유저명 넣기
        UserAccountDto userAccountDto = UserAccountDto.of("test email", "karma", "test password", "test description", RoleType.USER);
        CommentDto commentDto = WriteCommentRequest.to(writeCommentRequest);
        commentService.saveComment(userAccountDto, commentDto);
        return String.format("redirect:/articles/%s", writeCommentRequest.getArticleId());
    }

    @PutMapping("/{commentId}")
    public String updateComment(@PathVariable Long commentId, UpdateCommentRequest req){
        // TODO : 인증기능 구현 후 자기가 작성한 댓글만 수정할 수 있도록
        commentService.updateComment(commentId, req.getContent());
        return String.format("redirect:/articles/%s", req.getArticleId());
    }

    @PostMapping("/{commentId}")
    public String deleteComment(@PathVariable Long commentId, DeleteCommentRequest req){
        // TODO : 인증기능 구현 후 자기가 작성한 댓글만 삭제할 수 있도록
        commentService.deleteComment(commentId);
        return String.format("redirect:/articles/%s", req.getArticleId());
    }
}
