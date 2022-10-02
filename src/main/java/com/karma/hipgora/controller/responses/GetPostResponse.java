package com.karma.hipgora.controller.responses;

import com.karma.hipgora.model.post.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;
import java.util.Set;

@Getter
@AllArgsConstructor
public class GetPostResponse {
    private Long id;
    private String title;
    private String body;
    private String username;
    private Set<String> hashtags;
    private Timestamp registerAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static GetPostResponse from(Post post){
        return new GetPostResponse(
                post.getId(),
                post.getTitle(),
                post.getBody(),
                post.getUser().getUsername(),
                post.getHashtags(),
                post.getRegisteredAt(),
                post.getUpdatedAt(),
                post.getRemovedAt()
        );
    }
}
