package com.karma.chat.service

import com.karma.chat.model.Account
import com.karma.chat.repository.AccountRepository
import org.springframework.stereotype.Service

@Service
class AccountService (
    private val accountRepository: AccountRepository
){
    fun save(account:Account):Account{
        return this.accountRepository.save(account);
    }
}