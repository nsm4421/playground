package com.karma.chat.controller.dto.feed

data class ModifyFeedRequestDto(
    val feedId:Long,
    val content:String,
    val media:List<String>
)
