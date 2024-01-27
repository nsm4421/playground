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
@ToString(callSuper = true)
@Table(
        indexes = {
                @Index(columnList = "comment"),
                @Index(columnList = "createdAt"),
                @Index(columnList = "createdBy"),
        }
)
@Entity
public class ArticleComment extends AuditingFields{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter @ManyToOne(optional = false) private Article article;
    @Setter @Column(nullable = false, length = 500) private String comment;
    @Setter @ManyToOne(optional = false) private UserAccount userAccount;

    protected ArticleComment(){
    }

    public ArticleComment(UserAccount userAccount, Article article, String comment) {
        this.userAccount = userAccount;
        this.article = article;
        this.comment = comment;
    }

    public static ArticleComment of(UserAccount userAccount, Article article, String comment) {
        return new ArticleComment(userAccount, article, comment);
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
