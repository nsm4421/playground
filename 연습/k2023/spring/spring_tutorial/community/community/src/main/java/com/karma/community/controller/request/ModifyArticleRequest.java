package com.karma.community.controller.request;

import com.karma.community.model.dto.ArticleDto;
import lombok.Data;

import java.util.Set;

@Data
public class ModifyArticleRequest {
    private Long articleId;
    private String title;
    private String content;
    private Set<String> hashtags;

    private ModifyArticleRequest(Long articleId, String title, String content, Set<String> hashtags) {
        this.articleId = articleId;
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
    }

    protected ModifyArticleRequest() {
    }

    public static ModifyArticleRequest of(Long articleId, String title, String content, Set<String> hashtags) {
        return new ModifyArticleRequest(articleId, title, content, hashtags);
    }

    public ArticleDto toDto() {
        return ArticleDto.of(
                articleId,
                null,
                title,
                content,
                hashtags,
                null,
                null,
                null,
                null
        );
    }
}
