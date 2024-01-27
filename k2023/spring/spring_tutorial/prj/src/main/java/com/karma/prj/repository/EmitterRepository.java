package com.karma.prj.repository;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Repository
public class EmitterRepository {
    private final Map<String, SseEmitter> emitterMap = new HashMap<>();
    public SseEmitter setEmitter(Long userId, SseEmitter sseEmitter){
        emitterMap.put(getKey(userId), sseEmitter);
        log.info("Save sse emitter... userId :{}", userId);
        return sseEmitter;
    }
    public Optional<SseEmitter> getEmitter(Long userId){
        log.info("Get sse emitter... userId :{}", userId);
        return Optional.ofNullable(emitterMap.get(getKey(userId)));
    }
    public void removeEmitter(Long userId){
        emitterMap.remove(getKey(userId));
    }
    private String getKey(Long userId){
        return String.format("EMITTER__UID__%s", userId);
    }
}
