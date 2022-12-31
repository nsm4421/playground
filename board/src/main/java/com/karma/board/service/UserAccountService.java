package com.karma.board.service;

import com.karma.board.domain.RoleType;
import com.karma.board.domain.UserAccount;
import com.karma.board.exception.ErrorCode;
import com.karma.board.exception.MyException;
import com.karma.board.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;
    private final BCryptPasswordEncoder encoder;
    public UserAccount findByUsername(String username){
        return userAccountRepository
                .findByUsername(username)
                .orElseThrow(()->{throw new MyException(
                        ErrorCode.USER_NOT_FOUND,
                        String.format("Username [%s] is not founded", username));
        });
    }

    public void register(String email, String username, String password, String description){
        String encodedPassword = encoder.encode(password);
        UserAccount userAccount = UserAccount.of(email, username, encodedPassword, description, RoleType.USER);
        userAccountRepository.save(userAccount);
    }
}
