package com.karma.meeting.service;

import com.karma.meeting.model.dto.UserAccountDto;
import com.karma.meeting.model.util.*;
import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    // 회원가입
    public void register(String username, String nickname, String password, String email, Sex sex, String description, LocalDate birthAt){
        // 중복여부 체크
        if(isExist(fieldsNeedToCheckDuplicated.USERNAME, username)){throw new EntityExistsException("Username is duplicated...");};
        if(isExist(fieldsNeedToCheckDuplicated.EMAIL, email)){throw new EntityExistsException("Email is duplicated...");};
        if(isExist(fieldsNeedToCheckDuplicated.NICKNAME, nickname)){throw new EntityExistsException("nickname is duplicated...");};
        // 저장
        userAccountRepository.save(UserAccount.of(username,nickname,sex,passwordEncoder.encode(password),email,RoleType.USER,description,birthAt));
    }

    /**
     * 중복여부 검사 - 중복시 throw error
     * @param f : 중복여부 검사할 필드 (username, email, nickname)
     * @param keyword : 중복여부 검사할 값
     */
    private Boolean isExist(fieldsNeedToCheckDuplicated f, String keyword){
        return switch (f){
            case USERNAME ->  userAccountRepository.findByUsername(keyword).isPresent();
            case EMAIL ->  userAccountRepository.findByEmail(keyword).isPresent();
            case NICKNAME ->  userAccountRepository.findByNickname(keyword).isPresent();
        };
    }

    private enum fieldsNeedToCheckDuplicated {
        USERNAME,NICKNAME,EMAIL;
    }
}
