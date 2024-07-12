package com.karma.chat.controller.dto

data class BodyDto<T>(
    val message : String,
    val data : T? = null
)