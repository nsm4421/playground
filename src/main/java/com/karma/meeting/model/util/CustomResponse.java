package com.karma.meeting.model.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomResponse {
    private CustomState state;
    private String message = null;

    private CustomResponse(CustomState state, String message) {
        this.state = state;
        this.message = message;
    }

    protected CustomResponse(){}

    // 성공시
    public static CustomResponse of(CustomState state, String message){
        return new CustomResponse(state, message);
    }
    public static CustomResponse of(CustomState state){return new CustomResponse(state, state.getDescription());}
}
