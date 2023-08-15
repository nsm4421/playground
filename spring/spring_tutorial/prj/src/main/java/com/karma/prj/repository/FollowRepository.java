package com.karma.prj.repository;

import com.karma.prj.model.entity.FollowEntity;
import com.karma.prj.model.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.Set;

@Repository
public interface FollowRepository extends JpaRepository<FollowEntity, Long> {
    Set<FollowEntity> findByLeader_Nickname(String nickname);
    Set<FollowEntity> findByFollower_Nickname(String nickname);
    Optional<FollowEntity> findByLeaderAndFollower(UserEntity leader, UserEntity follower);
}