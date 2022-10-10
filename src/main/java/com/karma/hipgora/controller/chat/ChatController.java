package com.karma.hipgora.controller.chat;

import com.karma.hipgora.controller.requests.ReceivePublicChatRequest;
import com.karma.hipgora.controller.responses.ReceivePublicMessageResponse;
import com.karma.hipgora.model.chat.Chat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/v1/chat")
public class ChatController {

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @MessageMapping("/message")
    @SendTo("/chatroom/public")
    public ReceivePublicMessageResponse receivePublicMessage(
            @Payload ReceivePublicChatRequest receivePublicChatRequest){
        return ReceivePublicMessageResponse.from(receivePublicChatRequest);
    }

    @MessageMapping("/private-message")
    public Chat receivePrivateMessage(@Payload Chat chat){
        simpMessagingTemplate.convertAndSendToUser(chat.getReceiver().toString(),"/private",chat);
        return chat;
    }
}
