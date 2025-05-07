package com.karma.chat.controller.dto.auth

import com.karma.chat.domain.auth.Account

data class SignInResponseDto(
    val jwt: String,
    val account: Account
)
