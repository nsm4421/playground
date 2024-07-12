package com.karma.chat.domain.auditing

import jakarta.persistence.*
import org.springframework.data.annotation.CreatedBy
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedBy
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import org.springframework.format.annotation.DateTimeFormat
import java.time.LocalDateTime

@EntityListeners(AuditingEntityListener::class)
@MappedSuperclass
abstract class AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id")
    open var id: Long = 0
        protected set

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @CreatedDate
    @Column(updatable = false)
    open var createdAt: LocalDateTime? = null
        protected set

    @CreatedBy
    @Column(updatable = false, length = 100)
    open var createdBy: String? = null
        protected set

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @LastModifiedDate
    open var modifiedAt: LocalDateTime? = null
        protected set

    @LastModifiedBy
    @Column(length = 100)
    open var modifiedBy: String? = null
        protected set
}