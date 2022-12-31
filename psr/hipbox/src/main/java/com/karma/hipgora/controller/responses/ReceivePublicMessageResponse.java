package com.karma.hipgora.controller.responses;

import com.karma.hipgora.controller.requests.ReceivePublicChatRequest;
import com.karma.hipgora.model.chat.Status;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReceivePublicMessageResponse {
    private String sender;
    private String message;
    private Status status;
    private LocalDateTime createdAt;

    public static ReceivePublicMessageResponse from(ReceivePublicChatRequest receivePublicChatRequest){
        ReceivePublicMessageResponse receivePublicMessageResponse = new ReceivePublicMessageResponse();
        receivePublicMessageResponse.setSender(receivePublicChatRequest.getSender());
        receivePublicMessageResponse.setMessage(receivePublicChatRequest.getMessage());
        receivePublicMessageResponse.setStatus(receivePublicChatRequest.getStatus());
        receivePublicMessageResponse.setCreatedAt(LocalDateTime.now());
        return receivePublicMessageResponse;
    }
}
