package com.karma.prj.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum FollowingType {
    LEADER("팔로잉 당하는 사람"),
    FOLLOWER("팔로잉 하는 사람");
    private final String description;
}
