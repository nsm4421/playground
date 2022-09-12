package com.sns.karma.model.post;

import com.sns.karma.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class Post {
    private Long id = null;
    private String title;
    private String body;
    private User user;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static Post fromEntity(PostEntity postEntity) {
        return new Post(
                postEntity.getId(),
                postEntity.getTitle(),
                postEntity.getBody(),
                User.fromEntity(postEntity.getUser()),
                postEntity.getRegisteredAt(),
                postEntity.getUpdatedAt(),
                postEntity.getRemovedAt()
        );
    }
}