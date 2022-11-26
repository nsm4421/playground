package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.Message;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;


@Getter
@Setter
public class MessageDto {
    private Long roomId;
    private String createdBy;
    private String content;
    private LocalDateTime createdAt;

    private MessageDto(Long roomId, String createdBy, String content, LocalDateTime createdAt) {
        this.roomId = roomId;
        this.createdBy = createdBy;
        this.content = content;
        this.createdAt = createdAt;
    }

    protected MessageDto(){}

    public static MessageDto of(Long roomId, String createdBy, String content, LocalDateTime createdAt){
        return new MessageDto(roomId, createdBy, content, createdAt);
    }

    public static MessageDto from(Message m){
        return MessageDto.of(
                m.getChatRoom().getId(),
                m.getCreatedBy(),
                m.getContent(),
                m.getCreatedAt()
        );
    }
}
