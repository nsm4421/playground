package com.karma.chat.domain.feed

import com.karma.chat.domain.auditing.AuditingFields
import jakarta.persistence.Column
import jakarta.persistence.Entity

@Entity
class Feed (
    @Column(name="content", columnDefinition = "TEXT", length = 1000) var content :String,
    @Column(name="media") var media :List<String>,
):AuditingFields()