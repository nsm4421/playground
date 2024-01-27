package com.karma.meeting.model.entity;

import com.karma.meeting.model.util.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Setter
@Getter
@Entity
@Table(name = "comment")
@SQLDelete(sql = "UPDATE comment SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class Comment extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "content")
    private String content;

    @ManyToOne @JoinColumn(name="feed_id")
    private Feed feed;

    private Comment(String content, Feed feed) {
        this.content = content;
        this.feed = feed;
    }

    protected Comment(){}

    public static Comment of(String content, Feed feed){
        return new Comment(content, feed);
    }
}
