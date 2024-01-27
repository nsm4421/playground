package com.karma.prj.model.entity;

import com.karma.prj.model.dto.CommentDto;
import com.karma.prj.model.util.AuditingFields;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Table(name = "\"comment\"")
@Entity
public class CommentEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "content")
    private String content;
    @ManyToOne @JoinColumn(name = "user_id")
    private UserEntity user;
    @ManyToOne @JoinColumn(name = "post_id")
    private PostEntity post;

    private CommentEntity(String content, UserEntity user, PostEntity post) {
        this.content = content;
        this.user = user;
        this.post = post;
    }

    protected CommentEntity(){}

    public static CommentEntity of(String content, UserEntity user, PostEntity post){
        return new CommentEntity(content, user, post);
    }

    public static CommentDto dto(CommentEntity entity){
        return CommentDto.of(
                entity.getId(),
                entity.getPost().getId(),
                entity.getContent(),
                entity.getUser().getNickname(),
                entity.getCreatedAt(),
                entity.getModifiedAt(),
                entity.getCreatedBy(),
                entity.getModifiedBy()
        );
    }
}
