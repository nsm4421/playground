package com.karma.board.domain;

import com.karma.board.domain.dto.ArticleDto;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@Entity
@ToString
@Table(indexes = {
        @Index(columnList = "title"),
        @Index(columnList = "createdAt"),
        @Index(columnList = "createdBy")
})
@EntityListeners(AuditingFields.class)
public class Article extends AuditingFields{
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column @Setter
    private String title;
    @Column(nullable = false, length = 10000) @Setter
    private String content;
    @Column @Setter
    private String hashtags;

    @ToString.Exclude @ManyToOne
    private UserAccount userAccount;

    @ToString.Exclude @OrderBy("createdAt DESC") @OneToMany(mappedBy = "article", cascade = CascadeType.ALL)
    private final Set<Comment> comments = new LinkedHashSet<>();

    protected Article(){}

    public Article(String title, String content, String hashtags) {
        this.title = title;
        this.content = content;
        this.hashtags = hashtags;
    }

    public static Article of(String title, String content, String hashtags){
        return new Article(title, content, hashtags);
    }

    // Entity → Dto
    public static ArticleDto to(Article article){
        return ArticleDto.of(
                article.getId(), article.getTitle(), article.getContent(), article.getHashtags(),
                article.getCreatedAt(), article.getCreatedBy()
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Article that = (Article) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
