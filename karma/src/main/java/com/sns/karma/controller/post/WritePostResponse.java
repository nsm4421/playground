package com.sns.karma.controller.post;

import com.sns.karma.controller.user.UserResponse;
import com.sns.karma.model.post.Post;
import com.sns.karma.model.user.User;
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
