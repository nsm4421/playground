package com.karma.chat.controller.dto.chat

data class SendPrivateChatMessageRequestDto(
    val receiver: String,
    val jwt: String,
    val content: String
)