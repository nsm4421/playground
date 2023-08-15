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
@Table(name = "article", indexes = {
        @Index(columnList = "title"),
        @Index(columnList = "createdAt"),
        @Index(columnList = "createdBy")
})
@Entity
public class Article extends AuditingFields {
    /** Fields
     * articleId : primary key
     * userAccount : 글쓴이
     * title
     * content
     * articleComments
     * hashtags
     */

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long articleId;

    @Setter
    @JoinColumn(name = "username")
    @ManyToOne(optional = false)
    private UserAccount userAccount;

    @Setter
    @Column(nullable = false)
    private String title;
    @Setter
    @Column(nullable = false, length = 10000)
    private String content;

    @ElementCollection(fetch = FetchType.LAZY) @Setter
    private Set<String> hashtags;

    @ToString.Exclude
    @OrderBy("createdAt DESC")
    @OneToMany(mappedBy = "article", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private final Set<ArticleComment> articleComments = new LinkedHashSet<>();

    private Article(UserAccount userAccount, String title, String content, Set<String> hashtags) {
        this.userAccount = userAccount;
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
    }

    protected Article() {
    }

    public static Article of(UserAccount userAccount, String title, String content, Set<String> hashtags) {
        return new Article(userAccount, title, content, hashtags);
    }

    public static Article of(UserAccount userAccount, String title, String content) {
        return new Article(userAccount, title, content, Set.of());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Article that)) return false;
        return this.getArticleId() != null && this.getArticleId().equals(that.getArticleId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getArticleId());
    }
}

