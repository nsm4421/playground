package com.karma.chat.domain

import com.karma.chat.constant.UserRole
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class CustomUserDetail(
    private val uid: Long,
    private val username: String,
    private val role: UserRole,
) : UserDetails {

    override fun getAuthorities(): MutableCollection<out GrantedAuthority> =
        mutableListOf(SimpleGrantedAuthority(role.name))

    fun getUid(): Long = uid

    override fun getPassword(): String = ""

    override fun getUsername(): String = username

    companion object {
        fun from(account: Account): UserDetails {
            return CustomUserDetail(
                uid = account.id,
                username = account.username,
                role = account.role
            )
        }
    }
}