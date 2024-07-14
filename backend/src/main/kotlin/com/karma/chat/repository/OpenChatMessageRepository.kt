package com.karma.chat.repository

import com.karma.chat.domain.chat.OpenChatMessage
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface OpenChatMessageRepository : JpaRepository<OpenChatMessage, Long>