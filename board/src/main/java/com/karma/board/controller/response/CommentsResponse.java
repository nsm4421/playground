package com.karma.board.controller.response;

import com.karma.board.domain.dto.ArticleWithCommentDto;
import com.karma.board.domain.dto.CommentDto;
import lombok.Getter;

import java.util.Set;

@Getter
public class CommentsResponse {
    private Long articleId;
    private Set<CommentDto> comments;

    private CommentsResponse(Long articleId, Set<CommentDto> comments) {
        this.articleId = articleId;
        this.comments = comments;
    }
    protected CommentsResponse(){}
    public static CommentsResponse of(Long articleId, Set<CommentDto> comments){
        return new CommentsResponse(articleId, comments);
    }
    public static CommentsResponse from(ArticleWithCommentDto dto){
        return CommentsResponse.of(dto.getArticleId(), dto.getComments());
    }
}
