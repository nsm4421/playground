package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.ChatRoom;
import lombok.Getter;

@Getter
public class ChatRoomDto {
    private Long id;
    private String title;
    private UserAccountDto host;

    private ChatRoomDto(Long id, String title, UserAccountDto host) {
        this.id = id;
        this.title = title;
        this.host = host;
    }

    protected ChatRoomDto(){}

    public static ChatRoomDto of(Long id, String title, UserAccountDto host){
        return new ChatRoomDto(id, title, host);
    }

    public static ChatRoomDto from(ChatRoom c){
        return ChatRoomDto.of(c.getId(), c.getTitle(), UserAccountDto.from(c.getHost()));
    }
}
