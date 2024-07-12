package com.karma.chat.domain.auth

import com.fasterxml.jackson.annotation.JsonIgnore
import com.karma.chat.constant.UserRole
import com.karma.chat.domain.auditing.AccountAuditingFields
import jakarta.persistence.*
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Entity
class Account(
    @Column(unique = true, nullable = false, length = 100) val email :String,
    @Transient private val rawPassword: String,
    @Enumerated(EnumType.STRING) val role :UserRole = UserRole.USER,
):AccountAuditingFields(){

    var password : String = passwordEncoder.encode(rawPassword)
        @JsonIgnore
        get
        set(rawPassword) {
            field = passwordEncoder.encode(rawPassword)
        }

    fun subject () = "${this.username}:${this.role}"

    companion object {
        private val passwordEncoder = BCryptPasswordEncoder()
    }
}