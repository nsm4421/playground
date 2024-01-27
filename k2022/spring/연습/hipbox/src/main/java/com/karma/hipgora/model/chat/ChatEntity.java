package com.karma.hipgora.model.chat;

import com.karma.hipgora.model.AuditingFields;
import com.karma.hipgora.model.user.UserEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Getter
@Setter
@ToString(callSuper = true)
@Table(name = "\"chat\"")
@Entity
@SQLDelete(sql = "UPDATE \"chat\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class ChatEntity extends AuditingFields {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "sender_id")
    @Setter
    private UserEntity sender;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    @Setter
    private UserEntity receiver;

    @Column(columnDefinition = "TEXT", length = 3000)
    private String message;

    @Enumerated(EnumType.STRING)
    private Status status;

    public static ChatEntity of(UserEntity sender, UserEntity receiver, String message, Status status){
        ChatEntity chatEntity = new ChatEntity();
        chatEntity.setSender(sender);
        chatEntity.setReceiver(receiver);
        chatEntity.setMessage(message);
        chatEntity.setStatus(status);
        return chatEntity;
    }
}
