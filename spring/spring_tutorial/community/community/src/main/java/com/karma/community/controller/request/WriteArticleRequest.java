package com.karma.community.controller.request;

import com.karma.community.model.dto.ArticleDto;
import lombok.Data;

import java.util.Set;

@Data
public class WriteArticleRequest {
    private String title;
    private String content;
    private Set<String> hashtags;

    private WriteArticleRequest(String title, String content, Set<String> hashtags) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
    }

    protected WriteArticleRequest(){}

    public static WriteArticleRequest of(String title, String content, Set<String> hashtags){
        return new WriteArticleRequest(title, content, hashtags);
    }

    public ArticleDto toDto(){return ArticleDto.of(null, title, content, hashtags);}
}
