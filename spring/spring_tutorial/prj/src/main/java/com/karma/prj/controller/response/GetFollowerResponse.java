package com.karma.prj.controller.response;

import com.karma.prj.model.dto.UserDto;
import lombok.Data;

@Data
public class GetFollowerResponse {
    /**
     * TODO
     * 나중에 User Entity 변경하면, 더 많은 정보를 return 하도록 수정하기
     */
    private String nickname;

    private GetFollowerResponse(String nickname) {
        this.nickname = nickname;
    }

    protected GetFollowerResponse(){}

    public static GetFollowerResponse of(String nickname){
        return new GetFollowerResponse(nickname);
    }

    public static GetFollowerResponse from(UserDto dto){
        return GetFollowerResponse.of(dto.getNickname());
    }
}
