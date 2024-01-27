package com.karma.hipgora.controller.responses;

import com.karma.hipgora.controller.requests.ReceivePrivateChatRequest;
import com.karma.hipgora.model.chat.Status;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReceivedPrivateChatResponse {
    private String sender;
    private String receiver;
    private String message;
    private Status status;
    private LocalDateTime createdAt;

    public static ReceivedPrivateChatResponse from (ReceivePrivateChatRequest receivePrivateChatRequest){
        ReceivedPrivateChatResponse receivedPrivateChatResponse = new ReceivedPrivateChatResponse();
        receivedPrivateChatResponse.setSender(receivedPrivateChatResponse.getSender());
        receivedPrivateChatResponse.setReceiver(receivedPrivateChatResponse.getReceiver());
        receivedPrivateChatResponse.setMessage(receivedPrivateChatResponse.getMessage());
        receivedPrivateChatResponse.setCreatedAt(LocalDateTime.now());
        return receivedPrivateChatResponse;
    }    
}
