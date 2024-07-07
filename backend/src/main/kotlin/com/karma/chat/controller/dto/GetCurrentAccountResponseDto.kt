package com.karma.chat.controller.dto

import com.karma.chat.domain.Account

data class GetCurrentAccountResponseDto(
    val id: Long,
    val email: String,
    val username: String
) {
    companion object{
        fun from(account: Account): GetCurrentAccountResponseDto = GetCurrentAccountResponseDto(
            id = account.id,
            email = account.email,
            username = account.username
        )
    }
}
