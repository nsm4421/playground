package com.karma.chat.config.security

import com.karma.chat.constant.UserRole
import com.karma.chat.domain.auth.Account
import com.karma.chat.repository.AccountRepository
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.stereotype.Component

@Component
class AdminInitialize(
    private val accountRepository: AccountRepository
) : ApplicationRunner {
    override fun run(args: ApplicationArguments?) {
        accountRepository.save(
            Account(
                email = "nsm4421@naver.com",
                role = UserRole.ADMIN,
                rawPassword = "1221",
            )
        )    // 수정
    }
}