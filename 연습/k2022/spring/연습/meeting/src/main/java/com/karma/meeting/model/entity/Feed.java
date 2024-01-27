package com.karma.meeting.model.entity;

import com.karma.meeting.model.util.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Set;

@Setter
@Getter
@Entity
@Table(name = "feed")
@SQLDelete(sql = "UPDATE feed SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class Feed extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @ManyToOne @JoinColumn(name = "user_account_id")
    private UserAccount userAccount;

    @OneToMany(fetch = FetchType.LAZY) @JoinColumn(name = "feed_id")
    private Set<Comment> comments;

    private Feed(String title, String content, UserAccount userAccount, Set<Comment> comments) {
        this.title = title;
        this.content = content;
        this.userAccount = userAccount;
        this.comments = comments;
    }

    protected Feed(){}

    public static Feed of(String title, String content, UserAccount userAccount,  Set<Comment> comments){
        return new Feed(title, content, userAccount, comments);
    }
}
