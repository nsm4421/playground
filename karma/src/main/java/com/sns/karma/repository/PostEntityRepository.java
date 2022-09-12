package com.sns.karma.repository;

import com.sns.karma.model.post.PostEntity;;
import com.sns.karma.model.user.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PostEntityRepository extends JpaRepository<PostEntity, Long> {
    public Page<PostEntity> findAllByUser(UserEntity userEntity, Pageable pageable);
}
