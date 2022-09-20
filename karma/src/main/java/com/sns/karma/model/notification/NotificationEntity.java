package com.sns.karma.model.notification;

import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.UserEntity;
import com.vladmihalcea.hibernate.type.json.JsonBinaryType;
import com.vladmihalcea.hibernate.type.json.internal.JsonBytesSqlTypeDescriptor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;

@Setter
@Getter
@Entity
@Table(name = "\"notification\"",
        indexes = {@Index(name = "index_notificationTable_onUserId", columnList = "user_id")})
@SQLDelete(sql = "UPDATE \"notification\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@TypeDef(name="json_b_type", typeClass = JsonBinaryType.class)
@NoArgsConstructor
public class NotificationEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id = null;

    // 알림을 받는 사람
    @ManyToOne @JoinColumn(name = "user_id") private UserEntity user;

    // 알림 종류
    @Enumerated(EnumType.STRING) private NotificationType notificationType;

    // Arguments
    @Type(type="json_b_type")
    @Column(columnDefinition = "json")
    private NotificationArgs args;

    @Column(name = "registered_at") private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;

    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }

    public static NotificationEntity of(
            UserEntity userEntity,
            NotificationType notificationType,
            NotificationArgs args){
        NotificationEntity notificationEntity = new NotificationEntity();
        notificationEntity.setUser(userEntity);
        notificationEntity.setNotificationType(notificationType);
        notificationEntity.setArgs(args);
        return notificationEntity;
    }
}