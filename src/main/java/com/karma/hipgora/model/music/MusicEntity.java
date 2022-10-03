package com.karma.hipgora.model.music;

import com.karma.hipgora.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
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
    @Column(nullable = false)
    private String musicFilename;

    @Setter
    @Column(length = 1000, nullable = false)
    private String musicFilePath;

    @Setter
    @Column
    private String thumbnailFilename;

    @Setter
    @Column(length = 1000)
    private String thumbnailFilePath;

    @Setter
    @ElementCollection(fetch = FetchType.EAGER)
    @Column(name = "hashtags")
    private Set<String> hashtags = new HashSet<String>();

    public static MusicEntity of(String title, String description, Set<String> hashtags,
                                 String musicFilename, String musicFilePath,
                                 String thumbnailFilename, String thumbnailFilePath){
        MusicEntity musicEntity = new MusicEntity();
        musicEntity.setTitle(title);
        musicEntity.setDescription(description);
        musicEntity.setHashtags(hashtags);
        musicEntity.setMusicFilename(musicFilename);
        musicEntity.setMusicFilePath(musicFilePath);
        musicEntity.setThumbnailFilename(thumbnailFilename);
        musicEntity.setThumbnailFilePath(thumbnailFilePath);
        return musicEntity;
    }
}