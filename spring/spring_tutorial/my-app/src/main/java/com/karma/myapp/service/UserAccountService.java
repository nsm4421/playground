package com.karma.myapp.service;

import com.karma.myapp.domain.dto.AlarmDto;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.domain.dto.UserAccountDto;
import com.karma.myapp.domain.entity.AlarmEntity;
import com.karma.myapp.domain.entity.UserAccountEntity;
import com.karma.myapp.exception.CustomErrorCode;
import com.karma.myapp.exception.CustomException;
import com.karma.myapp.repository.AlarmRepository;
import com.karma.myapp.repository.PrincipalRedisRepository;
import com.karma.myapp.repository.UserAccountRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.util.Date;


@Service
@RequiredArgsConstructor
@Transactional
public class UserAccountService {

    private final UserAccountRepository userAccountRepository;
    private final PrincipalRedisRepository principalRedisRepository;
    private final AlarmRepository alarmRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    // JWT 비밀키
    @Value("${jwt.secret-key}")
    private String secretKey;
    // JWT 만료 시간
    @Value("${jwt.expire-ms}")
    private Long expireMs;

    /**
     * Email 회원가입
     *
     * @param username 유저명
     * @param email    이메일
     * @param password (raw)비밀번호
     * @param memo     메모
     * @return DTO
     */
    public UserAccountDto signUp(String username, String email, String password, String memo) {
        // check duplicated or not
        userAccountRepository.findByUsername(username).ifPresent(it -> {
            throw CustomException.of(CustomErrorCode.DUPLICATED_ENTITY, String.format("Username is duplicated - %s", username));
        });
        userAccountRepository.findByEmail(email).ifPresent(it -> {
            throw CustomException.of(CustomErrorCode.DUPLICATED_ENTITY, String.format("Email is duplicated - %s", email));
        });
        // save
        return UserAccountDto.from(userAccountRepository.save(
                UserAccountEntity.of(
                        username,
                        email,
                        passwordEncoder.encode(password),
                        memo
                )
        ));
    }

    /**
     * 로그인
     *
     * @param username 유저명
     * @param password (raw) 비밀전호
     * @return token(JWT)
     */
    public String login(String username, String password) {
        // get principal
        CustomPrincipal principal = loadByUsername(username);

        // check password
        if (!passwordEncoder.matches(password, principal.getPassword())) {
            throw CustomException.of(CustomErrorCode.INVALID_PASSWORD, "Password is wrong");
        }

        // set principal in redis
        principalRedisRepository.setPrincipal(principal);

        // create access token
        return generateToken("username", username);
    }

    /**
     * 유저 정보 수정
     *
     * @param principal 로그인한 유저 principal
     * @param email     수정할 이메일
     * @param password  수정할 비밀번호
     * @param memo      수정할 메모
     * @return UserAccount Dto
     */
    public UserAccountDto modifyUserInfo(CustomPrincipal principal, String email, String password, String memo) {
        // modify principal
        principal.setEmail(email);
        principal.setPassword(passwordEncoder.encode(password));
        principal.setMemo(memo);

        // set principal in redis
        principalRedisRepository.setPrincipal(principal);

        // save in DB
        return UserAccountDto.from(userAccountRepository.save(UserAccountEntity.from(principal)));
    }

    /**
     * 알림 가져오기
     *
     * @param principal 로그인한 유저의 인증정보
     * @param pageable
     * @return 알림 page
     */
    @Transactional(readOnly = true)
    public Page<AlarmDto> getAlarms(CustomPrincipal principal, Pageable pageable) {
        UserAccountEntity user = UserAccountEntity.from(principal);
        return alarmRepository.findByUser(user, pageable).map(AlarmDto::from);
    }

    /**
     * 단일 알람 삭제
     *
     * @param principal 로그인한 유저의 인증 정보
     * @param alarmId   삭제할 알림 id
     */
    public void deleteAlarm(CustomPrincipal principal, Long alarmId) {
        AlarmEntity alarm = alarmRepository.getReferenceById(alarmId);
        if (!alarm.getUser().equals(UserAccountEntity.from(principal))) {
            throw CustomException.of(CustomErrorCode.NOT_GRANT, "not granted access for alarm");
        }
        ;
        alarmRepository.deleteById(alarmId);
    }

    /**
     * 모든 알림 삭제
     *
     * @param principal 로그인한 유저의 인증정보
     */
    public void deleteAllAlarm(CustomPrincipal principal) {
        alarmRepository.deleteByUser(UserAccountEntity.from(principal));
    }

    @Transactional(readOnly = true)
    public CustomPrincipal loadByUsername(String username) {
        // find user in redis cache
        return principalRedisRepository.getUser(username)
                .orElseGet(() -> CustomPrincipal.from(
                        // or else find user in DB
                        userAccountRepository.findByUsername(username)
                                // or else throw
                                .orElseThrow(() -> {
                                    throw CustomException.of(
                                            CustomErrorCode.ENTITY_NOT_FOUND,
                                            String.format("Username %s not exists", username)
                                    );
                                })
                ));
    }

    public String generateToken(String key, String value){
        // create access token
        Claims claims = Jwts.claims();
        claims.put(key, value);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expireMs))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8)), SignatureAlgorithm.HS256)
                .compact();
    }
}
