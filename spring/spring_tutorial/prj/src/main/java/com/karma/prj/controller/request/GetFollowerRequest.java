package com.karma.prj.controller.request;

import com.karma.prj.model.util.FollowingType;
import lombok.Data;

@Data
public class GetFollowerRequest {
    private String nickname;
    private FollowingType followingType;
}
