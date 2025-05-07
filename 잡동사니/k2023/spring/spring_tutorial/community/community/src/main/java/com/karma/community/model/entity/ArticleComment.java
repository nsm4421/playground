package com.karma.community.model.entity;

import com.karma.community.model.util.AuditingFields;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@ToString(callSuper = true)
@Table(
        name = "article_comment",
        indexes = {
                @Index(columnList = "content"),
                @Index(columnList = "createdAt"),
                @Index(columnList = "parentCommentId")
        })
@Entity
public class ArticleComment extends AuditingFields {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long articleCommentId;

    @Setter
    @ManyToOne(optional = false)
    private Article article;

    @Setter
    @JoinColumn(name = "username")
    @ManyToOne(optional = false)
    private UserAccount userAccount;

    @Setter
    @Column(updatable = false)
    private Long parentCommentId;

    @ToString.Exclude
    @OrderBy("createdAt ASC")
    @OneToMany(mappedBy = "parentCommentId", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private final Set<ArticleComment> childComments = new LinkedHashSet<>();

    @Setter
    @Column(nullable = false, length = 500)
    private String content;


    private ArticleComment(Article article, UserAccount userAccount, Long parentCommentId, String content) {
        this.article = article;
        this.userAccount = userAccount;
        this.parentCommentId = parentCommentId;
        this.content = content;
    }

    protected ArticleComment() {
    }

    // 댓글 Entity 생성
    public static ArticleComment of(Article article, UserAccount userAccount, String content) {
        return new ArticleComment(article, userAccount, null, content);
    }

    // 대댓글 Entity 생성
    public static ArticleComment of(Article article, UserAccount userAccount, Long parentCommentId, String content) {
        return new ArticleComment(article, userAccount, parentCommentId, content);
    }

    // 대댓글 저장
    public void addChildComment(ArticleComment child) {
        child.setParentCommentId(this.getArticleCommentId());
        this.getChildComments().add(child);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ArticleComment that)) return false;
        return this.getArticleCommentId() != null && this.getArticleCommentId().equals(that.getArticleCommentId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getArticleCommentId());
    }
}
