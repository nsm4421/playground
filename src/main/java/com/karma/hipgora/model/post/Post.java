package com.karma.hipgora.model.post;

import com.karma.hipgora.model.user.User;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
public class Post {
    private Long id;
    private String title;
    private String body;
    private User user;
    private Set<String> hashtags;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime removedAt;

    public static Post from(PostEntity postEntity){
        Post post = new Post();
        post.setId(postEntity.getId());
        post.setTitle(postEntity.getTitle());
        post.setBody(postEntity.getBody());
        post.setUser(User.from(postEntity.getUserEntity()));
        post.setHashtags(post.getHashtags());
        post.setCreatedAt(post.getCreatedAt());
        post.setModifiedAt(post.getModifiedAt());
        post.setRemovedAt(post.getRemovedAt());
        return post;
    }
}
