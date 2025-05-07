package com.karma.prj.model.entity;

import com.karma.prj.model.dto.FollowDto;
import com.karma.prj.model.util.AuditingFields;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

@Setter
@Getter
@Entity
@Table(name = "follow")
@SQLDelete(sql = "UPDATE follow SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class FollowEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.DETACH) @JoinColumn
    private UserEntity leader;
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.DETACH) @JoinColumn
    private UserEntity follower;
    private FollowEntity(UserEntity leader, UserEntity follower) {
        this.leader = leader;
        this.follower = follower;
    }

    protected FollowEntity(){}

    public static FollowEntity of(UserEntity leader, UserEntity follower){
        return new FollowEntity(leader, follower);
    }

    public static FollowDto dto(FollowEntity entity){
        return FollowDto.of(
                UserEntity.dto(entity.getLeader()),
                UserEntity.dto(entity.getFollower())
        );
    }
}