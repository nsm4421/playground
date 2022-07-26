package com.karma.karmaboard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@ToString
@Table(
        indexes = {
                @Index(columnList = "comment"),
                @Index(columnList = "createdAt"),
                @Index(columnList = "createdBy"),
        }
)
@Entity
@EntityListeners(AuditingEntityListener.class)
public class ArticleComment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter @ManyToOne(optional = false) private Article article;
    @Setter @Column(nullable = false, length = 500) private String comment;

    @CreatedDate @Column(nullable = false)  private LocalDateTime createdAt;
    @CreatedDate @Column(nullable = false) private LocalDateTime modifiedAt;
    @CreatedBy @Column(nullable = false, length = 100) private String createdBy;
    @LastModifiedBy @Column(nullable = false, length = 100) private String modifiedBy;

    protected ArticleComment(){
    }

    public ArticleComment(Article article, String comment) {
        this.article = article;
        this.comment = comment;
    }

    public static ArticleComment of(Article article, String comment) {
        return new ArticleComment(article, comment);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ArticleComment that)) return false;
        return id != null && id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
