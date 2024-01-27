package com.sns.karma.model.like;

import com.sns.karma.model.post.Post;
import com.sns.karma.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class Like {
    private Long id = null;
    private User user;
    private Post post;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static Like fromEntity(LikeEntity likeEntity) {
        return new Like(
                likeEntity.getId(),
                User.fromEntity(likeEntity.getUser()),
                Post.fromEntity(likeEntity.getPost()),
                likeEntity.getRegisteredAt(),
                likeEntity.getUpdatedAt(),
                likeEntity.getRemovedAt()
        );
    }
}