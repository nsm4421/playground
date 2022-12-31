package com.karma.board.controller.request;

import com.karma.board.domain.Article;
import lombok.Data;

@Data
public class WriteArticleRequest {
    private String title;
    private String content;
    private String hashtags;

    private WriteArticleRequest(String title, String content, String hashtags) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
    }

    protected WriteArticleRequest(){}

    public static WriteArticleRequest of(String title, String content, String hashtags){
        return new WriteArticleRequest(title, content, hashtags);
    }

    // Request → Entity
    public static Article to(WriteArticleRequest writeArticleRequest){
        return Article.of(
                writeArticleRequest.getTitle(),
                writeArticleRequest.getContent(),
                writeArticleRequest.getHashtags()
        );
    }
}
