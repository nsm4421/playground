package com.karma.chat.domain.chat

import com.karma.chat.domain.auditing.AuditingFields
import jakarta.persistence.Entity

@Entity
class PrivateChatMessage(
    val content: String,
    val sender: String,
    val receiver: String,
) : AuditingFields()