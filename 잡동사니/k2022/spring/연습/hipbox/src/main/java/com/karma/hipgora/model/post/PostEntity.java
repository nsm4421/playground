package com.karma.hipgora.model.post;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.karma.hipgora.model.AuditingFields;
import com.karma.hipgora.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@ToString(callSuper = true)
@Table(name = "\"post\"",
        indexes = {
                @Index(columnList="title")
        })
@Entity
@SQLDelete(sql = "UPDATE \"post\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class PostEntity extends AuditingFields {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @Column(name="title", nullable = false)
    private String title;

    @Setter
    @Column(name="body", length = 3000, columnDefinition = "TEXT")
    private String body;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @Setter
    private UserEntity userEntity;

    @Setter
    @ElementCollection(fetch = FetchType.EAGER)
    @Column(name = "hashtags")
    private Set<String> hashtags = new HashSet<String>();

    public static PostEntity of(String title, String body, UserEntity userEntity, Set<String> hashtags){
        PostEntity postEntity = new PostEntity();
        postEntity.setTitle(title);
        postEntity.setBody(body);
        postEntity.setUserEntity(userEntity);
        postEntity.setHashtags(hashtags);
        return postEntity;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PostEntity that = (PostEntity) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}