package com.karma.hipgora.controller.responses;

import com.karma.hipgora.model.post.Post;
import com.karma.hipgora.model.post.PostEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@AllArgsConstructor
public class GetPostResponse {
    private Long id;
    private String title;
    private String body;
    private String username;
    private Set<String> hashtags;
    private LocalDateTime createdAt;

    public static GetPostResponse from(PostEntity postEntity){
        return new GetPostResponse(
                postEntity.getId(),
                postEntity.getTitle(),
                postEntity.getBody(),
                postEntity.getUserEntity().getUsername(),
                postEntity.getHashtags(),
                postEntity.getCreatedAt()
        );
    }
}
