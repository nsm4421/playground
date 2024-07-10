package com.karma.chat.controller.dto.feed

data class CreateFeedRequestDto(
    val content:String,
    val media:List<String>
)