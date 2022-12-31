package com.sns.karma.controller.comment.response;


import com.sns.karma.model.comment.Comment;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class GetCommentResponse {
    private Long id;
    private String comment;         // 댓글
    private String username;        // 댓쓴이
    private Long postId;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static GetCommentResponse fromDto(Comment comment) {
        return new GetCommentResponse(
                comment.getId(),
                comment.getComment(),
                comment.getUserName(),
                comment.getPostId(),
                comment.getRegisteredAt(),
                comment.getUpdatedAt(),
                comment.getRemovedAt()
        );
    }
}
