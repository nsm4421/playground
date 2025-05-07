package com.karma.community.model.entity;

import com.karma.community.model.util.AuditingFields;
import com.karma.community.model.util.EmotionType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "emotion", indexes = {@Index(columnList = "emotionType")})
@Getter
public class Emotion extends AuditingFields {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long emotionId;

    @Setter
    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    private Article article;

    @Setter
    @JoinColumn(name = "username")
    @ManyToOne(optional = false)
    private UserAccount userAccount;

    @Enumerated(value = EnumType.STRING)
    @Column(nullable = false)
    @Setter
    private EmotionType emotionType;

    private Emotion(Article article, UserAccount userAccount, EmotionType emotionType) {
        this.article = article;
        this.userAccount = userAccount;
        this.emotionType = emotionType;
    }

    protected Emotion() {
    }

    public static Emotion of(Article article, UserAccount userAccount, EmotionType emotionType) {
        return new Emotion(article, userAccount, emotionType);
    }
}
