package com.sns.karma.model.comment;

import com.sns.karma.model.like.LikeEntity;
import com.sns.karma.model.post.Post;
import com.sns.karma.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class Comment {
    private Long id;
    private String comment;
    private Long userId;
    private String userName;
    private Long postId;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static Comment fromEntity(CommentEntity commentEntity) {
        return new Comment(
                commentEntity.getId(),
                commentEntity.getComment(),
                commentEntity.getUser().getId(),
                commentEntity.getUser().getUserName(),
                commentEntity.getPost().getId(),
                commentEntity.getRegisteredAt(),
                commentEntity.getUpdatedAt(),
                commentEntity.getRemovedAt()
        );
    }
}