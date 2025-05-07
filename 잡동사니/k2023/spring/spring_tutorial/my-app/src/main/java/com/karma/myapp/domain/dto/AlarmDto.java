package com.karma.myapp.domain.dto;

import com.karma.myapp.domain.constant.AlarmType;
import com.karma.myapp.domain.entity.AlarmEntity;

import java.time.LocalDateTime;

public record AlarmDto(
        Long id,
        UserAccountDto user,
        AlarmType alarmType,
        String message,
        String memo,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy,
        LocalDateTime removedAt
) {
    public static AlarmDto from(AlarmEntity entity){
        return new AlarmDto(
                entity.getId(),
                UserAccountDto.from(entity.getUser()),
                entity.getAlarmType(),
                entity.getMessage(),
                entity.getMemo(),
                entity.getCreatedAt(),
                entity.getCreatedBy(),
                entity.getModifiedAt(),
                entity.getModifiedBy(),
                entity.getRemovedAt()
        );
    }
}
