package com.karma.prj.model.entity;

import com.karma.prj.model.dto.NotificationDto;
import com.karma.prj.model.util.AuditingFields;
import com.karma.prj.model.util.NotificationType;
import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
@Table(name = "notification")
public class NotificationEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "user_id")
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "post_id")
    private PostEntity post;
    @Enumerated(EnumType.STRING)
    private NotificationType notificationType;
    @Column(columnDefinition = "TEXT")
    private String message;

    private NotificationEntity(UserEntity user, PostEntity post, NotificationType notificationType, String message) {
        this.user = user;
        this.post = post;
        this.notificationType = notificationType;
        this.message = message;
    }

    protected NotificationEntity(){}

    public static NotificationEntity of(UserEntity user, PostEntity post, NotificationType notificationType, String message) {
        return new NotificationEntity(user, post, notificationType, message);
    }

    public static NotificationDto dto(NotificationEntity entity) {
        return NotificationDto.of(
                entity.getId(),
                UserEntity.dto(entity.getUser()),
                PostEntity.dto(entity.getPost()),
                entity.getNotificationType(),
                entity.getMessage(),
                entity.getCreatedAt()
        );
    }
}