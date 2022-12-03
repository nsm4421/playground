package com.karma.meeting.service;

import com.karma.meeting.model.util.CustomPrincipal;
import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.model.util.CustomErrorCode;
import com.karma.meeting.model.util.RoleType;
import com.karma.meeting.model.util.Sex;
import com.karma.meeting.model.util.CustomException;
import com.karma.meeting.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    // 회원가입
    public CustomPrincipal register(String username, String nickname, String password, String email, Sex sex, String description, LocalDate birthAt){
        // 중복여부 체크
        checkDuplicated(field.USERNAME, username);
        checkDuplicated(field.EMAIL, email);
        checkDuplicated(field.NICKNAME, nickname);
        // 저장
        UserAccount userAccount = UserAccount.of(username,nickname,sex,passwordEncoder.encode(password),email,RoleType.USER,description,birthAt);
        return CustomPrincipal.from(userAccountRepository.save(userAccount));
    }

    /**
     * 중복여부 검사 - 중복시 throw error
     * @param f : 중복여부 검사할 필드 (username, email, nickname)
     * @param keyword : 중복여부 검사할 값
     */
    private void checkDuplicated(field f, String keyword){
        switch (f){
            case USERNAME -> {
                if(userAccountRepository.findByUsername(keyword).isPresent()){
                    throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 이미 존재하는 유저명입니다.", keyword));
                }
            }
            case EMAIL -> {
                if(userAccountRepository.findByEmail(keyword).isPresent()){
                    throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 이미 존재하는 이메일입니다.", keyword));
                }
            }
            case NICKNAME -> {
                if(userAccountRepository.findByNickname(keyword).isPresent()){
                    throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 이미 존재하는 닉네임입니다.", keyword));
                }
            }
            default -> throw new CustomException(
                    CustomErrorCode.INTERNAL_SERVER_ERROR,  "잘못된 파라메터가 주어짐");
        };
    }

    private UserAccount findBy(field f, String keyword){
        return switch (f){
            case USERNAME->userAccountRepository.findByUsername(keyword)
                    .orElseThrow(()->{throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 존재하지 않는 유저명입니다", keyword)
                    );});
            case NICKNAME -> userAccountRepository.findByNickname(keyword)
                    .orElseThrow(()->{throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 존재하지 않는 닉네임입니다", keyword)
                    );});
            case EMAIL -> userAccountRepository.findByEmail(keyword)
                    .orElseThrow(()->{throw new CustomException(
                            CustomErrorCode.DUPLICATED_ENTITY,
                            String.format("[%s]는 존재하지 않는 이메일입니다", keyword)
                    );});
            default -> throw new CustomException(
                    CustomErrorCode.INTERNAL_SERVER_ERROR,  "잘못된 파라메터가 주어짐");
        };
    }
    private enum field{
        USERNAME,NICKNAME,EMAIL;
    }
}
