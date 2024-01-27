package com.sns.karma.repository;

import com.sns.karma.model.notification.NotificationEntity;
import com.sns.karma.model.user.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationEntityRepository extends JpaRepository<NotificationEntity, Long> {
    Page<NotificationEntity> findAllByUser(UserEntity userEntity, Pageable pageable);
}
