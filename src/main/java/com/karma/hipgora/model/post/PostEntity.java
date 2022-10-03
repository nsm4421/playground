package com.karma.hipgora.model.post;


import com.karma.hipgora.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Getter
@ToString(callSuper = true)
@Table(name = "\"post\"",
        indexes = {
                @Index(columnList="title")
        })
@Entity
@SQLDelete(sql = "UPDATE \"post\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class PostEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @Column(name="title", nullable = false)
    private String title;

    @Setter
    @Column(name="body", length = 3000, columnDefinition = "TEXT")
    private String body;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @Setter
    private UserEntity userEntity;

    @Setter
    @ElementCollection(fetch = FetchType.LAZY)
    @Column(name = "hashtags")
    private Set<String> hashtags = new HashSet<String>();

    @Column(name = "registered_at")  private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    public static PostEntity of(String title, String body, UserEntity userEntity, Set<String> hashtags){
        PostEntity postEntity = new PostEntity();
        postEntity.setTitle(title);
        postEntity.setBody(body);
        postEntity.setUserEntity(userEntity);
        postEntity.setHashtags(hashtags);
        return postEntity;
    }

    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }
}