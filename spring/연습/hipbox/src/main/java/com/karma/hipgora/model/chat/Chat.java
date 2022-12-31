package com.karma.hipgora.model.chat;

import com.karma.hipgora.model.user.User;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Chat {
    private User sender;
    private User receiver;
    private String message;
    private LocalDateTime createdAt;
    private LocalDateTime removedAt;
    private Status status;

    public Chat from(ChatEntity chatEntity){
        Chat chat = new Chat();
        chat.setSender(User.from(chatEntity.getSender()));
        chat.setReceiver(User.from(chatEntity.getReceiver()));
        chat.setMessage(chatEntity.getMessage());
        chat.setCreatedAt(chatEntity.getCreatedAt());
        chat.setRemovedAt(chatEntity.getRemovedAt());
        chat.setStatus(chatEntity.getStatus());
        return chat;
    }
}
