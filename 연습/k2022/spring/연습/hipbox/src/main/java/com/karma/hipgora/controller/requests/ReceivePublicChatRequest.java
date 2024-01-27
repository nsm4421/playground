package com.karma.hipgora.controller.requests;

import com.karma.hipgora.model.chat.Status;
import com.karma.hipgora.model.user.User;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Data
public class ReceivePublicChatRequest {
    private String sender;
    private String message;
    private Status status;
}
