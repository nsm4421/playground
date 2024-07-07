package com.karma.chat.domain

import jakarta.persistence.*
import org.hibernate.annotations.CreationTimestamp
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import java.time.LocalDateTime

@MappedSuperclass
@EntityListeners(AuditingEntityListener::class)
abstract class AuditingFields {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id : Long = 0

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false, columnDefinition = "DATETIME")
    protected lateinit var createdAt: LocalDateTime

    @LastModifiedDate
    @Column(name = "modified_at", nullable = false, columnDefinition = "DATETIME")
    protected lateinit var modifiedAt: LocalDateTime
}