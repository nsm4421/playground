package com.karma.board.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@Entity
@ToString
@Table(indexes = {
        @Index(columnList = "createdAt"),
        @Index(columnList = "createdBy")
})
@EntityListeners(AuditingFields.class)
public class Comment extends AuditingFields{
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(optional = false) @Setter
    private Article article;
    @Setter @Column(nullable = false, length = 1000)
    private String content;

    protected Comment(){}

    private Comment(Article article, String content) {
        this.article = article;
        this.content = content;
    }

    private Comment(Article article, String content, LocalDateTime createdAt, String createdBy) {
        this.article = article;
        this.content = content;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    public static Comment of(Article article, String content){
        return new Comment(article, content);
    }
    public static Comment of(Article article, String content, LocalDateTime createdAt, String createdBy){
        return new Comment(article, content, createdAt, createdBy);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment = (Comment) o;
        return id.equals(comment.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
