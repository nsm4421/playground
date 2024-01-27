package com.karma.commerce.repository;

import com.karma.commerce.domain.entity.UserAccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface UserAccountRepository extends JpaRepository<UserAccountEntity, Long> {

    @Query("select count(*) from UserAccountEntity u WHERE u.username = :username")
    long isExistUsername(@Param("username") String username);

    @Query("select count(*) from UserAccountEntity u WHERE u.email = :email")
    long isExistEmail(@Param("email") String email);

    Optional<UserAccountEntity> findByEmail(String email);

}
