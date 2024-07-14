package com.karma.chat.service


import com.karma.chat.domain.chat.OpenChatMessage
import com.karma.chat.domain.chat.PrivateChatMessage
import com.karma.chat.repository.OpenChatMessageRepository
import com.karma.chat.repository.PrivateChatMessageRepository
import org.springframework.stereotype.Service

@Service
class ChatService(
    private val openChatMessageRepository: OpenChatMessageRepository,
    private val privateChatMessageRepository: PrivateChatMessageRepository
) {
    fun saveOpenChatMessage(content: String, sender: String): OpenChatMessage = openChatMessageRepository.save(
        OpenChatMessage(
            content = content,
            sender = sender
        )
    )

    fun savePrivateChatMessage(content: String, sender: String, receiver: String): PrivateChatMessage =
        privateChatMessageRepository.save(
            PrivateChatMessage(
                content = content,
                sender = sender,
                receiver = receiver
            )
        )

}