package com.karma.chat.model

import jakarta.persistence.*
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Entity
class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    var id : Long = 0

    @Column
    var username = ""

    @Column(unique = true)
    var email = ""

    @Column
    var password=""
        get() = field
        set(value) {
            val passwordEncoder = BCryptPasswordEncoder();
            field = passwordEncoder.encode(value)
        }
}