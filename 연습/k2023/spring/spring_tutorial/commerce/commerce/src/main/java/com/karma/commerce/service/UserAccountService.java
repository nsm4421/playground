package com.karma.commerce.service;

import com.karma.commerce.domain.constant.UserRole;
import com.karma.commerce.domain.constant.UserStatus;
import com.karma.commerce.domain.dto.UserAccountDto;
import com.karma.commerce.domain.entity.UserAccountEntity;
import com.karma.commerce.repository.UserAccountRepository;
import jakarta.persistence.EntityExistsException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;

    public UserAccountDto register(String username, String email, String imgUrl, String password) {
        // check duplicated or not
        if (userAccountRepository.isExistUsername(username) > 0) {
            throw new EntityExistsException(String.format("Username %s already exists", username));
        }
        if (userAccountRepository.isExistEmail(email) > 0) {
            throw new EntityExistsException(String.format("Email %s already exists", email));
        }
        return UserAccountDto.from(
                userAccountRepository.save(
                        UserAccountEntity.of(username, email, imgUrl, password, UserRole.USER, UserStatus.ACTIVE)
                )
        );
    }

    public UserAccountDto signUp(String username, String email, String imgUrl) {
        return UserAccountDto.from(userAccountRepository.findByEmail(email)
                .orElseGet(() -> userAccountRepository.save(
                        UserAccountEntity.of(username, email, imgUrl, null, UserRole.USER, UserStatus.ACTIVE)
                )));
    }
}
