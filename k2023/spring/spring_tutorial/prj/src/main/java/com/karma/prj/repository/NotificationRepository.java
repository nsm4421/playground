package com.karma.prj.repository;

import com.karma.prj.model.entity.NotificationEntity;
import com.karma.prj.model.entity.PostEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface NotificationRepository extends JpaRepository<NotificationEntity, Long> {
    Page<NotificationEntity> findAllByUserId(Long userId, Pageable pageable);
    @Transactional
    @Modifying
    @Query(value = "UPDATE NotificationEntity entity SET removedAt = NOW() where entity.post = :post")
    void deleteAllByPost(@Param("post") PostEntity post);
    void deleteAllByUserId(Long userId);
}
