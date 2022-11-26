package com.karma.meeting.model.entity;

import com.karma.meeting.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Set;

@Entity
@Getter
@Setter
public class ChatRoom extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;

    @ManyToOne
    private UserAccount host;

    @OneToMany(mappedBy = "chatRoom", cascade = CascadeType.ALL)
    private Set<Message> messages;

    private ChatRoom(String title, Set<Message> messages, UserAccount host) {
        this.title = title;
        this.messages = messages;
        this.host = host;
    }

    protected ChatRoom(){}

    public static ChatRoom of(String title, Set<Message> messages, UserAccount host){
        return new ChatRoom(title, messages, host);
    }

    public static ChatRoom of(String title, UserAccount host){
        return new ChatRoom(title, Set.of(), host);
    }
}
