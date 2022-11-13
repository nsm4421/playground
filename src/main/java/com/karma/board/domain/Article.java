package com.karma.board.domain;

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

    @ToString.Exclude @OrderBy("id") @OneToMany(mappedBy = "article", cascade = CascadeType.ALL)
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
