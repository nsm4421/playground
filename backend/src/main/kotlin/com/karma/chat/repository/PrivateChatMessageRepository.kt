package com.karma.chat.repository

import com.karma.chat.domain.chat.PrivateChatMessage
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface PrivateChatMessageRepository : JpaRepository<PrivateChatMessage, Long>