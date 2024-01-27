package com.karma.community.repository;

import com.karma.community.model.entity.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserAccountRepository extends JpaRepository<UserAccount, String> {
    Optional<UserAccount> findByUsername(String username);

    @Query(value = """
            SELECT COUNT(*)
            FROM UserAccount entity
            WHERE entity.username = :username OR
            entity.nickname = :nickname OR
            entity.email = :email
            """)
    Long countDuplicated(
            @Param("username") String username,
            @Param("nickname") String nickname,
            @Param("email") String email
    );

    @Query(value = """
            SELECT COUNT(*)
            FROM UserAccount entity
            WHERE entity.username = :username
            """)
    Long countDuplicatedUsername(@Param("username") String username);

    @Query(value = """
            SELECT COUNT(*)
            FROM UserAccount entity
            WHERE entity.nickname = :nickname
            """)
    Long countDuplicatedNickname(@Param("nickname") String nickname);

    @Query(value = """
            SELECT COUNT(*)
            FROM UserAccount entity
            WHERE entity.email = :email
            """)
    Long countDuplicatedEmail(@Param("email") String email);
}
