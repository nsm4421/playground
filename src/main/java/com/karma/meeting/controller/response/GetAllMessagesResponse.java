package com.karma.meeting.controller.response;

import com.karma.meeting.model.dto.MessageDto;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Data
public class GetAllMessagesResponse {
    private Set<oneMessage> messages;
    private static class oneMessage {
        private String createdBy;
        private String content;
        private LocalDateTime createdAt;

        private oneMessage(String createdBy, String content, LocalDateTime createdAt) {
            this.createdBy = createdBy;
            this.content = content;
            this.createdAt = createdAt;
        }
        protected oneMessage(){}
        public static oneMessage of (String createdBy, String content, LocalDateTime createdAt){
            return new oneMessage(createdBy, content, createdAt);
        }
        public static oneMessage from(MessageDto dto){
            return oneMessage.of(dto.getCreatedBy(), dto.getContent(), dto.getCreatedAt());
        }
    }
    private GetAllMessagesResponse(Set<oneMessage> messages) {
        this.messages = messages;
    }
    public static GetAllMessagesResponse of(Set<oneMessage> messages){
        return new GetAllMessagesResponse(messages);
    }
    public static GetAllMessagesResponse from(Set<MessageDto> dtoSet){
        return GetAllMessagesResponse.of(dtoSet.stream()
                .map(oneMessage::from)
                .collect(Collectors.toSet()));
    }
}
