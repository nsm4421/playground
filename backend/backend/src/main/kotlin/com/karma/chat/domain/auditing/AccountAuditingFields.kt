package com.karma.chat.domain.auditing

import jakarta.persistence.*
import org.hibernate.annotations.GenericGenerator
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import org.springframework.format.annotation.DateTimeFormat
import java.time.LocalDateTime
import java.util.*

@EntityListeners(AuditingEntityListener::class)
@MappedSuperclass
abstract class AccountAuditingFields {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
        name = "UUID",
        strategy = "org.hibernate.id.UUIDGenerator"
    )
    val username: String = UUID.randomUUID().toString()

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @CreatedDate
    @Column(updatable = false)
    var createdAt: LocalDateTime? = null
        protected set

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @LastModifiedDate
    var modifiedAt: LocalDateTime? = null
        protected set
}