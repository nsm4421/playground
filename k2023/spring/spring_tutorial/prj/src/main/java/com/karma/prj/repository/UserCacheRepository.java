package com.karma.prj.repository;

import com.karma.prj.model.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;
import java.util.Optional;

@Slf4j
@Repository
@RequiredArgsConstructor
public class UserCacheRepository {
    private final RedisTemplate<String, UserEntity> userRedisTemplate;
    private final static Duration USER_CACHE_DURATION = Duration.ofDays(3);
    public void setUserByUsername(UserEntity user){
        String key = getKey(user.getUsername());
        log.info("setUser {}", key);
        userRedisTemplate.opsForValue().set(key,user, USER_CACHE_DURATION);
    }
    public Optional<UserEntity> getUserByUsername(String username){
        String key = getKey(username);
        UserEntity user = userRedisTemplate.opsForValue().get(key);
        log.info("getUser {}", key);
        return Optional.ofNullable(user);
    }
    private static String getKey(String username){
        return String.format("USER__USERNAME__%s", username);
    }
}
