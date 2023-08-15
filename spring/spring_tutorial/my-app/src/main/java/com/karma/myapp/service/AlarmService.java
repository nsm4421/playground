package com.karma.myapp.service;

import com.karma.myapp.domain.constant.AlarmType;
import com.karma.myapp.domain.dto.AlarmMessageDto;
import com.karma.myapp.domain.entity.AlarmEntity;
import com.karma.myapp.domain.entity.UserAccountEntity;
import com.karma.myapp.exception.CustomErrorCode;
import com.karma.myapp.exception.CustomException;
import com.karma.myapp.repository.AlarmRepository;
import com.karma.myapp.repository.SseEmitterRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlarmService {
    private final AlarmRepository alarmRepository;
    private final SseEmitterRepository sseEmitterRepository;
    private final KafkaTemplate<String, AlarmMessageDto> kafkaTemplate;
    @Value("${sse.timeout}")
    private Long TIMEOUT;
    @Value("${sse.event-name}")
    private String EVENT_NAME;

    @Value("${spring.kafka.template.default-topic}")
    private String TOPIC;

    /**
     * Producer - Kafka 서버로 알람 보내기
     * @param dto 알람 dto
     */
    public void sendAlarmToKafka(AlarmMessageDto dto) {
        final String key = "AID_" + dto.id();
        try {
            kafkaTemplate.send(TOPIC, key, dto);
            log.info("Produce the event - key:{}", key);
        } catch (Exception e) {
            log.info("Produce fail - key:{} error:{}", key, e.toString());
        }
    }

    /**
     * Consumer - kafka 서버로 부터 알람 전달하기
     * @param record 알람 json string
     * @param ack acknowledgement
     */
    @KafkaListener(topics = "${spring.kafka.template.default-topic}", groupId = "${spring.kafka.consumer.group-id}")
    public void listen(ConsumerRecord<String, AlarmMessageDto> record, Acknowledgment ack) {
        log.info("Consume the event - json:{}", record.key());
        ack.acknowledge();
    }

    /**
     * Client에게 알람 보내기
     * @param entity Alarm Entity
     */
    public void sendAlarm(AlarmEntity entity) {
        sendAlarmToKafka(AlarmMessageDto.from(entity));
        sseEmitterRepository.getEmitter(entity.getUser().getUsername()).ifPresentOrElse(it -> {
            try {
                it.send(SseEmitter
                        .event()
                        .id(entity.getId().toString())
                        .name(EVENT_NAME)
                        .data(AlarmMessageDto.from(entity))
                );
            } catch (IOException e) {
                throw CustomException.of(CustomErrorCode.INTERNAL_SERVER_ERROR, "Send Alarm failed");
            }
        }, () -> log.info("No Emitter found"));
    }

    /**
     * SSE에 연결
     * @param username 유저명
     * @return Emitter
     */
    public SseEmitter connect(String username) {
        SseEmitter sseEmitter = new SseEmitter(TIMEOUT);
        sseEmitterRepository.saveEmitter(username, sseEmitter);
        sseEmitter.onCompletion(() -> sseEmitterRepository.removeEmitter(username));
        sseEmitter.onTimeout(() -> sseEmitterRepository.removeEmitter(username));
        try {
            sseEmitter.send(SseEmitter.event().id(username).name(EVENT_NAME));
        } catch (IOException ioException) {
            throw CustomException.of(CustomErrorCode.INTERNAL_SERVER_ERROR, "Sse connection failed");
        }
        return sseEmitter;
    }

    /**
     * DB에 알람 저장
     * @param user      로그인한 유저
     * @param alarmType 알람 유형
     * @param message   메세지
     * @param memo      메모
     * @return Alarm Entity
     */
    public AlarmEntity saveAlarm(UserAccountEntity user, AlarmType alarmType, String message, String memo) {
        return alarmRepository.save(AlarmEntity.of(user, alarmType, message, memo));
    }
}
