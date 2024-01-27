package com.sns.karma.controller.post.response;

import com.sns.karma.model.post.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class WritePostResponse {
    private Long id;
    private String title;

    public static WritePostResponse fromPost(Post post){
        return new WritePostResponse(
                post.getId(),
                post.getTitle()
        );
    }
}
