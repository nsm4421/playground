package com.karma.voucher.repository;

import com.karma.voucher.model.user.UserGroupMappingEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserGroupMappingRepository extends JpaRepository<UserGroupMappingEntity, Integer> {
    List<UserGroupMappingEntity> findByUserGroupId(String userGroupId);
}
