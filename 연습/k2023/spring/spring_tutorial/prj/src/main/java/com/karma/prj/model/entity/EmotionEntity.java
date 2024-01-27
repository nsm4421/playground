package com.karma.prj.model.entity;

import com.karma.prj.model.dto.EmotionDto;
import com.karma.prj.model.util.AuditingFields;
import com.karma.prj.model.util.EmotionType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

@Setter
@Getter
@Entity
@Table(name = "emotion")
@SQLDelete(sql = "UPDATE emotion SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class EmotionEntity extends AuditingFields {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "user_id")
    private UserEntity user;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "post_id")
    private PostEntity post;
    @Enumerated(EnumType.STRING)
    private EmotionType emotionType;

    private EmotionEntity(UserEntity user, PostEntity post, EmotionType emotionType) {
        this.user = user;
        this.post = post;
        this.emotionType = emotionType;
    }

    protected EmotionEntity(){}

    public static EmotionEntity of(UserEntity user, PostEntity post, EmotionType emotionType) {
        return new EmotionEntity(user, post, emotionType);
    }

    public static EmotionDto dto(EmotionEntity entity){
        return EmotionDto.of(
                entity.getUser().getUsername(),
                entity.getPost().getId(),
                entity.getEmotionType()
        );
    }
}
