package com.karma.chat.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.karma.chat.constant.UserRole
import jakarta.persistence.*
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder


@Entity
class Account(
    @Column(unique = true, nullable = false) val username :String,
    @Column(unique = true, nullable = false) val email :String,
    @Transient private val rawPassword: String,
    @Enumerated(EnumType.STRING) val role :UserRole = UserRole.USER,
): AuditingFields() {


    var password : String = passwordEncoder.encode(rawPassword)
        @JsonIgnore
        get() = field
        set(rawPassword) {
            field = passwordEncoder.encode(rawPassword)
        }

    fun subject () = "${this.username}:${this.role}"

    companion object {
        private val passwordEncoder = BCryptPasswordEncoder()
    }
}