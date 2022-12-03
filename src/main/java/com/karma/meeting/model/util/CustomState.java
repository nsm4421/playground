package com.karma.meeting.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
public enum CustomState {
    SUCCESS("성공"),
    DUPLICATED_ENTITY("중복된 엔티티"),
    INTERNAL_SERVER_ERROR("서버 에러"),
    ENTITY_NOT_FOUNDED("존재하지 않는 엔티티"),
    UNAUTHORIZED("인증되지 않음");
    private String description;
}