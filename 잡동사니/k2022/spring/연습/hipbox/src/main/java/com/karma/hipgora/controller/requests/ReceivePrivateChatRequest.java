package com.karma.hipgora.controller.requests;

import com.karma.hipgora.model.chat.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReceivePrivateChatRequest {
    private String sender;
    private String receiver;
    private String message;
    private Status status;
}
