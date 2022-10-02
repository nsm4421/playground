package com.karma.hipgora.model.post;

import com.karma.hipgora.model.user.User;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.Set;

@Getter
@Setter
public class Post {
    private Long id;
    private String title;
    private String body;
    private User user;
    private Set<String> hashtags;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static Post from(PostEntity postEntity){
        Post post = new Post();
        post.setId(postEntity.getId());
        post.setTitle(postEntity.getTitle());
        post.setBody(postEntity.getBody());
        post.setUser(User.from(postEntity.getUserEntity()));
        post.setHashtags(post.getHashtags());
        post.setRegisteredAt(post.getRegisteredAt());
        post.setUpdatedAt(post.getUpdatedAt());
        post.setRemovedAt(post.getRemovedAt());
        return post;
    }
}
