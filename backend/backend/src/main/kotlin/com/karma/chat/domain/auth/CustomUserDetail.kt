package com.karma.chat.domain.auth

import com.karma.chat.constant.UserRole
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails

class CustomUserDetail(
    private val username: String,
    private val role: UserRole,
) : UserDetails {

    override fun getAuthorities(): MutableCollection<out GrantedAuthority> =
        mutableListOf(SimpleGrantedAuthority(role.name))

    override fun getPassword(): String = ""

    override fun getUsername(): String = username

    companion object {
        fun from(account: Account): UserDetails {
            return CustomUserDetail(
                username = account.username,
                role = account.role
            )
        }
        fun from(account: User): UserDetails {
            val authority = when(account.authorities.first().authority){
                "USER" -> UserRole.USER
                "ADMIN" -> UserRole.ADMIN
                else -> UserRole.ANONYMOUS
            }
            return CustomUserDetail(
                username = account.username,
                role = authority
            )
        }
    }
}