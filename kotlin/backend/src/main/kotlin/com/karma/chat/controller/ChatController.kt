package com.karma.chat.controller


import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.chat.SendPrivateChatMessageRequestDto
import com.karma.chat.controller.dto.chat.SendPublicChatMessageRequestDto
import com.karma.chat.domain.chat.OpenChatMessage
import com.karma.chat.domain.chat.PrivateChatMessage
import com.karma.chat.service.AccountService
import com.karma.chat.service.ChatService
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.Payload
import org.springframework.messaging.handler.annotation.SendTo
import org.springframework.messaging.simp.SimpMessagingTemplate
import org.springframework.web.bind.annotation.RestController

@RestController
class ChatController(
    private val accountService: AccountService,
    private val chatService: ChatService,
    private val messagingTemplate: SimpMessagingTemplate
) {
    @MessageMapping("/message")
    @SendTo("/chat/public")
    fun handlePublicMessage(@Payload req: SendPublicChatMessageRequestDto): BodyDto<OpenChatMessage> {
        val sender = accountService.extractUsernameFromJwt(req.jwt)
        val message = chatService.saveOpenChatMessage(content = req.content, sender = sender)
        return BodyDto(message = "success", data = message)
    }

    @MessageMapping
    @SendTo("/chat/private")
    fun handlePrivateMessage(@Payload req: SendPrivateChatMessageRequestDto): BodyDto<PrivateChatMessage> {
        val sender = accountService.extractUsernameFromJwt(req.jwt)
        val message =
            chatService.savePrivateChatMessage(content = req.content, sender = sender, receiver = req.receiver)
        return BodyDto(message = "success", data = message)
    }
}