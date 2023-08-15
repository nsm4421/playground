package com.karma.prj.model.dto;

import lombok.Getter;

@Getter
public class FollowDto {
    private UserDto leader;
    private UserDto follower;

    private FollowDto(UserDto leader, UserDto follower) {
        this.leader = leader;
        this.follower = follower;
    }

    protected FollowDto(){}

    public static FollowDto of(UserDto leader, UserDto follower){
        return new FollowDto(leader, follower);
    }
}
