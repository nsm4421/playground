package com.karma.myapp.repository;

import com.karma.myapp.domain.dto.CustomPrincipal;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;
import java.util.Optional;

@Repository
@Slf4j
@RequiredArgsConstructor
public class PrincipalRedisRepository {
    // key값에 사용될 prefix
    private static final String prefix = "PRINCIPAL";
    // 캐싱 유효기간 (단위 : 日)
    @Value("${spring.redis.ttl.principal}")
    private Integer TTL;
    private final RedisTemplate<String, CustomPrincipal> principalRedisTemplate;

    /**
     * Key값 생성하기
     *
     * @param username 유저명
     * @return PRINCIPAL_[유저명]
     */
    private String key(String username) {
        return prefix + "_" + username;
    }

    /**
     * Getter
     *
     * @param username 유저명
     * @return 인증정보
     */
    public Optional<CustomPrincipal> getUser(String username) {
        log.info("UserAccountRedisRepository.getUser username:{}", username);
        return Optional.ofNullable(principalRedisTemplate.opsForValue().get(key(username)));
    }

    /**
     * Setter
     *
     * @param principal 캐시에 저장할 인증정보
     */
    public void setPrincipal(CustomPrincipal principal) {
        log.info("UserAccountRedisRepository.setPrincipal username:{}", principal.getUsername());
        principalRedisTemplate.opsForValue().set(key(principal.getUsername()), principal, Duration.ofDays(TTL));
    }
}
