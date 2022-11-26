package com.karma.meeting.model.entity;

import com.karma.meeting.model.AuditingFields;
import lombok.Getter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Getter
@ToString
public class Message extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private ChatRoom chatRoom;
    @ManyToOne @JoinColumn(name = "username")
    private UserAccount userAccount;
    @Column(columnDefinition = "TEXT")
    private String content;

    private Message(ChatRoom chatRoom, UserAccount userAccount, String content) {
        this.chatRoom = chatRoom;
        this.userAccount = userAccount;
        this.content = content;
    }

    protected Message(){}

    public static Message of(ChatRoom chatRoom, UserAccount userAccount, String content){
        return new Message(chatRoom, userAccount, content);
    }
}
