package com.karma.chat.service

import com.karma.chat.domain.auth.Account
import com.karma.chat.domain.auth.CustomUserDetail
import com.karma.chat.repository.AccountRepository
import com.karma.chat.util.JwtUtil
import jakarta.transaction.Transactional
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
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

    fun signUpWithEmailAndPassword(email: String, rawPassword: String): String {
        val account = Account(email = email, rawPassword = rawPassword)
        return this.accountRepository.save(account).username
    }

    fun signInWithEmailAndPassword(email: String, rawPassword: String): Account = accountRepository.findByEmail(email)
        ?.takeIf { passwordEncoder.matches(rawPassword, it.password) }
        ?: throw IllegalArgumentException("user not found or password is not matched")

    fun extractUsernameFromJwt(jwt: String): String = jwtUtil.extractSubject(jwt)
        ?.let { it -> it.split(":")[0] }
        ?: throw IllegalAccessException("jwt is not valid")

    fun generateJwt(account: Account): String = jwtUtil.generateToken(account.subject())
}