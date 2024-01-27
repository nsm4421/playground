package com.karma.myapp.repository;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Repository
public class SseEmitterRepository {
    private final Map<String, SseEmitter> emitterMap = new HashMap<>();

    public Optional<SseEmitter> getEmitter(String username) {
        final String key = getKey(username);
        log.info("SseEmitterRepository.getEmitter key:{}", key);
        return Optional.ofNullable(emitterMap.get(key));
    }

    public void saveEmitter(String username, SseEmitter sseEmitter) {
        final String key = getKey(username);
        log.info("SseEmitterRepository.saveEmitter key:{}", key);
        emitterMap.put(key, sseEmitter);
    }

    public void removeEmitter(String username) {
        final String key = getKey(username);
        emitterMap.remove(key);
    }

    private String getKey(String username) {
        return String.format("Sse-Emitter-%s", username);
    }
}
