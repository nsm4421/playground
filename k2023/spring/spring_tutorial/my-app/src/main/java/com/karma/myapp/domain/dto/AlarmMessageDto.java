package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.constant.AlarmType;
import com.karma.myapp.domain.entity.AlarmEntity;

import java.time.LocalDateTime;

public record AlarmMessageDto(
        Long id,
        AlarmType alarmType,
        String message,
        String memo,
        LocalDateTime createdAt
){
    public static AlarmMessageDto from(AlarmDto dto){
        return new AlarmMessageDto(
                dto.id(),
                dto.alarmType(),
                dto.message(),
                dto.memo(),
                dto.createdAt()
        );
    }
    public static AlarmMessageDto from(AlarmEntity entity){
        return from(AlarmDto.from(entity));
    }
}
