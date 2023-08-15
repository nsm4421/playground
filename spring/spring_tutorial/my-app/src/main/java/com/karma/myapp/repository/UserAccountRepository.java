package com.karma.myapp.repository;

import com.karma.myapp.domain.entity.UserAccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface UserAccountRepository extends JpaRepository<UserAccountEntity, Long> {
    @Transactional(readOnly = true)
    Optional<UserAccountEntity> findByUsername(String username);
    @Transactional(readOnly = true)
    Optional<UserAccountEntity> findByEmail(String email);
}
