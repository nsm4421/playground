package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.Message;
import com.karma.meeting.model.enums.MessageType;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;


@Getter
@Setter
public class MessageDto {
    private Long roomId;
    private String sender;
    private String content;
    private LocalDateTime createdAt;
    private MessageType messageType;

    private MessageDto(Long roomId, String sender, String content, LocalDateTime createdAt, MessageType messageType) {
        this.roomId = roomId;
        this.sender = sender;
        this.content = content;
        this.createdAt = createdAt;
        this.messageType = messageType;
    }

    protected MessageDto(){}

    public static MessageDto of(Long roomId, String sender, String content, LocalDateTime createdAt, MessageType messageType){
        return new MessageDto(roomId, sender, content, createdAt, messageType);
    }

    public static MessageDto from(Message m){
        return MessageDto.of(
                m.getChatRoom().getId(),
                m.getCreatedBy(),
                m.getContent(),
                m.getCreatedAt(),
                m.getMessageType()
        );
    }
}