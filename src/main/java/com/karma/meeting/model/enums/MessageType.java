package com.karma.meeting.model.enums;

import lombok.Getter;

@Getter
public enum MessageType {
    /**
     * ENTER : 채팅방 입장
     * COMM : 대화 (Communication)
     * EXIT : 채팅방 퇴장
     */
    ENTER, COMM, EXIT;
}
