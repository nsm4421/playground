package com.karma.chat.repository

import com.karma.chat.domain.auth.Account
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface AccountRepository: JpaRepository<Account, String>{
    fun findByEmail(email:String): Account?
    fun findByUsername(username:String): Account?
}