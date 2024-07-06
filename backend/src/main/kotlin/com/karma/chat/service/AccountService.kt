package com.karma.chat.service

import com.karma.chat.domain.Account
import com.karma.chat.repository.AccountRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service

@Service
class AccountService (
    private val accountRepository: AccountRepository
){
    fun findById(id:Long): Account?{
        return this.accountRepository.findByIdOrNull(id)
    }
    fun findByEmail(email:String): Account?{
        return this.accountRepository.findByEmail(email)
    }
    fun save(account: Account): Account {
        return this.accountRepository.save(account)
    }
}