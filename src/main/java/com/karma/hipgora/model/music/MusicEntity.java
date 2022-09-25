package com.karma.hipgora.model.music;

import com.karma.hipgora.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Getter
@ToString(callSuper = true)
@Table(name = "\"music\"",
        indexes = {
                @Index(columnList="title")
        })
@Entity
@SQLDelete(sql = "UPDATE \"music\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class MusicEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @Column(nullable = false)
    private String title;

    @Setter
    @Column(length = 1000)
    private String description;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @Setter
    private UserEntity userEntity;

    @Setter
    @Column
    private String filename;

    @Setter
    @Column(length = 1000)
    private String filePath;

    @Setter
    @ElementCollection(fetch = FetchType.LAZY)
    @Column(name = "hashtags")
    private Set<String> hashtags = new HashSet<String>();

    @Column(name = "registered_at")  private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    public static MusicEntity of(String title, String description, UserEntity userEntity,
                                 String filename, String filePath, Set<String> hashtags){
        MusicEntity musicEntity = new MusicEntity();
        musicEntity.setTitle(title);
        musicEntity.setDescription(description);
        musicEntity.setUserEntity(userEntity);
        musicEntity.setFilename(filename);
        musicEntity.setFilePath(filePath);
        musicEntity.setHashtags(hashtags);
        return musicEntity;
    }

    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }
}