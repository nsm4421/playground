package com.karma.myapp.controller.response;

import com.karma.myapp.domain.constant.AlarmType;
import com.karma.myapp.domain.dto.AlarmDto;

import java.time.LocalDateTime;

public record GetAlarmResponse(
        Long id,
        AlarmType alarmType,
        String message,
        String memo,
        LocalDateTime createdAt
) {
    public static GetAlarmResponse from(AlarmDto dto) {
        return new GetAlarmResponse(
                dto.id(),
                dto.alarmType(),
                dto.message(),
                dto.memo(),
                dto.createdAt()
        );
    }
}
