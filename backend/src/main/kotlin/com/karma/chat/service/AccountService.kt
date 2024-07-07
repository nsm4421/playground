package com.karma.chat.service

import com.karma.chat.domain.Account
import com.karma.chat.domain.CustomUserDetail
import com.karma.chat.repository.AccountRepository
import com.karma.chat.util.JwtUtil
import jakarta.transaction.Transactional
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.stereotype.Service

@Service
@Transactional
class AccountService(
    private val accountRepository: AccountRepository,
    private val passwordEncoder: BCryptPasswordEncoder,
    private val jwtUtil: JwtUtil
) : UserDetailsService {

    override fun loadUserByUsername(username: String): UserDetails {
        val account = findByUsername(username)
            ?: throw UsernameNotFoundException("username is not given")
        return CustomUserDetail.from(account)
    }

    fun findByUsername(username: String): Account? = this.accountRepository.findByUsername(username)

    fun signUpWithEmailAndPassword(email: String, username: String, rawPassword: String): Long {
        val account = Account(username = username, email = email, rawPassword = rawPassword)
        return this.accountRepository.save(account).id
    }

    fun signInWithEmailAndPassword(email: String, password: String): String {
        val account = accountRepository.findByEmail(email)
            ?.takeIf { passwordEncoder.matches(password, it.password) }
            ?: throw IllegalArgumentException("user not found or password is not matched")
        return jwtUtil.generateToken(account.subject())
    }
}