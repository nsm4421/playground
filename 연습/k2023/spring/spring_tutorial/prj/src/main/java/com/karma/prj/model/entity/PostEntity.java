package com.karma.prj.model.entity;

import com.karma.prj.model.dto.PostDto;
import com.karma.prj.model.util.AuditingFields;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Setter
@Getter
@Entity
@Table(name = "post")
@SQLDelete(sql = "UPDATE post SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class PostEntity extends AuditingFields {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "title", nullable = false)
    private String title;
    @Column(name = "content", columnDefinition = "TEXT", nullable = false)
    private String content;
    @ElementCollection(fetch = FetchType.LAZY)
    private Set<String> hashtags = new HashSet<String>();
    @ManyToOne @JoinColumn(name = "user_id")
    private UserEntity user;
    @OneToMany(fetch = FetchType.LAZY) @JoinColumn(name = "post_id")
    private List<CommentEntity> comments;

    private PostEntity(String title, String content, UserEntity user, Set<String> hashtags, List<CommentEntity> comments) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
        this.user = user;
        this.comments = comments;
    }

    protected PostEntity(){}

    public static PostEntity of(String title, String content, UserEntity user, Set<String> hashtags) {
        return new PostEntity(title, content, user, hashtags, List.of());
    }

    public static PostDto dto(PostEntity entity){
        return PostDto.of(
                entity.getId(),
                entity.getTitle(),
                entity.getContent(),
                entity.getUser().getNickname(),
                entity.getHashtags(),
                entity.getCreatedAt(),
                entity.getModifiedAt(),
                entity.getCreatedBy(),
                entity.getModifiedBy()
        );
    }
}
