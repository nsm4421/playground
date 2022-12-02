package com.karma.meeting.controller.response;

import com.karma.meeting.model.entity.ChatRoom;
import lombok.Data;

@Data
public class GetChatRoomsResponse {
    private Long id;
    private String title;
    private String host;

    private GetChatRoomsResponse(Long id, String title, String host) {
        this.id = id;
        this.title = title;
        this.host = host;
    }

    public static GetChatRoomsResponse of (Long id, String title, String host){
        return new GetChatRoomsResponse(id, title, host);
    }

    public static GetChatRoomsResponse from (ChatRoom chatRoom){
        return GetChatRoomsResponse.of(chatRoom.getId(), chatRoom.getTitle(), chatRoom.getHost().getUsername());
    }
}
