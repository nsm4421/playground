package com.karma.community.controller.request;

import com.karma.community.model.dto.ArticleCommentDto;
import com.karma.community.model.dto.UserAccountDto;
import lombok.Data;
import org.springframework.security.core.parameters.P;

@Data
public class SaveArticleCommentRequest {
    private Long articleId;
    private Long parentCommentId;
    private String content;

    private SaveArticleCommentRequest(Long articleId, Long parentCommentId, String content) {
        this.articleId = articleId;
        this.parentCommentId = parentCommentId;
        this.content = content;
    }

    protected SaveArticleCommentRequest(){}

    public static SaveArticleCommentRequest of(Long articleId, Long parentCommentId, String content){
        return SaveArticleCommentRequest.of(articleId, parentCommentId, content);
    }

    public ArticleCommentDto toDto(UserAccountDto user){
        if (parentCommentId == null){
            return ArticleCommentDto.of(articleId, user, content);
        }
        return ArticleCommentDto.of(articleId, user, parentCommentId, content);
    }
}
