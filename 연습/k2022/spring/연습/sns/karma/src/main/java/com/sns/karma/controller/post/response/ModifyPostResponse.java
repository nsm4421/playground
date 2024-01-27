package com.sns.karma.controller.post.response;

import com.sns.karma.controller.user.response.UserResponse;
import com.sns.karma.model.post.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class ModifyPostResponse {
    private Long id;
    private String title;
    private String body;
    private UserResponse userResponse;
    private Timestamp registerAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static ModifyPostResponse fromPost(Post post){
        return new ModifyPostResponse(
                post.getId(),
                post.getTitle(),
                post.getBody(),
                UserResponse.fromUser(post.getUser()),
                post.getRegisteredAt(),
                post.getUpdatedAt(),
                post.getRemovedAt()
        );
    }
}
