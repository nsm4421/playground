package com.karma.chat.domain.chat

import com.karma.chat.domain.auditing.AuditingFields
import jakarta.persistence.Entity

@Entity
class OpenChatMessage(
    val content: String,
    val sender: String
) : AuditingFields()