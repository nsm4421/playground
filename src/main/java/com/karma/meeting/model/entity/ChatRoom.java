package com.karma.meeting.model.entity;

import com.karma.meeting.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
public class ChatRoom extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String title;
    @ManyToOne private UserAccount host;

    private ChatRoom(String title, UserAccount host) {
        this.title = title;
        this.host = host;
    }

    protected ChatRoom(){}

    public static ChatRoom of(String title, UserAccount host){
        return new ChatRoom(title, host);
    }
}
