package com.karma.myapp.domain.entity;

import com.karma.myapp.domain.constant.BaseEntity;
import com.karma.myapp.domain.constant.EmotionConst;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.Objects;

@Entity
@Getter
@ToString(callSuper = true)
@Table(name = "EMOTION")
@SQLDelete(sql = "UPDATE EMOTION SET removed_at = NOW() WHERE id=?")   // soft delete
@Where(clause = "removed_at is NULL")
@EntityListeners(AuditingEntityListener.class)  // jpa auditing
public class EmotionEntity extends BaseEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Enumerated(value = EnumType.STRING) @Setter
    private EmotionConst emotion;
    @ManyToOne @JoinColumn(name = "user_id")
    private UserAccountEntity user;
    @ManyToOne @JoinColumn(name = "article_id")
    private ArticleEntity article;

    private EmotionEntity(Long id, EmotionConst emotion, UserAccountEntity user, ArticleEntity article) {
        this.id = id;
        this.emotion = emotion;
        this.user = user;
        this.article = article;
    }

    protected EmotionEntity(){}

    public static EmotionEntity of(EmotionConst emotion, UserAccountEntity user, ArticleEntity article){
        return new EmotionEntity(null, emotion, user, article);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof EmotionEntity that)) return false;
        return this.getId() != null && this.getId().equals(that.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
