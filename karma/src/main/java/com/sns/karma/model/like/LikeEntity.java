package com.sns.karma.model.like;

import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;

@Setter
@Getter
@Entity
@Table(name = "\"like\"")
@SQLDelete(sql = "UPDATE \"EVALUATION\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class LikeEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id = null;

    @Column(name = "body", columnDefinition = "TEXT", nullable = false)
    private String body;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name = "post_id")
    private PostEntity post;

    @Column(name = "registered_at") private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }

    public static LikeEntity of(UserEntity userEntity, PostEntity postEntity) {
        LikeEntity LikeEntity = new LikeEntity();
        LikeEntity.setUser(userEntity);
        LikeEntity.setPost(postEntity);
        return LikeEntity;
    }
}