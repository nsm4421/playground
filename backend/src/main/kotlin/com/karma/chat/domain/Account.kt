package com.karma.chat.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.karma.chat.constant.UserRole
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import jakarta.persistence.*
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import java.util.*

@Entity
class Account(): AuditingFields() {

    @Column
    var username :String = ""

    @Column(unique = true)
    var email : String  = ""

    @Column
    var password : String = ""
        @JsonIgnore
        get() = field
        set(rawPassword) {
            val passwordEncoder = BCryptPasswordEncoder();
            field = passwordEncoder.encode(rawPassword)
        }

    @Enumerated(EnumType.STRING)
    var role : UserRole = UserRole.USER

    fun comparePassword(rawPassword:String):Boolean{
        return BCryptPasswordEncoder().matches(rawPassword, password)
    }

    fun generateJwt(secret:String, day:Int = 1):String{
        return Jwts.builder().setIssuer(id.toString())
            .setExpiration(Date(System.currentTimeMillis()*60*24*day))
            .signWith(SignatureAlgorithm.HS512, secret)
            .compact()
    }
}