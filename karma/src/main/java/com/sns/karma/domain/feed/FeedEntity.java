package com.sns.karma.domain.feed;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.domain.user.UserRoleEnum;
import com.sns.karma.domain.user.UserStateEnum;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;

@Setter
@Getter
@Entity
@Table(name = "\"feed\"")
@SQLDelete(sql = "UPDATE \"feed\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class FeedEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "title", nullable = false) private String title;
    @Column(name = "title", nullable = false, columnDefinition = "TEXT") private String body;

    @ManyToOne @JoinColumn(name = "user_id") private UserEntity userEntity;

    @Column(name = "registered_at") private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    @PrePersist void registeredAt() { this.registeredAt = Timestamp.from(Instant.now());}

    @PreUpdate void updatedAt() { this.updatedAt = Timestamp.from(Instant.now());}

}
