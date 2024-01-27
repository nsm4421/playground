package com.karma.hipgora.repository;

import com.karma.hipgora.model.post.PostEntity;
import com.karma.hipgora.model.user.User;
import com.karma.hipgora.model.user.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PostEntityRepository extends JpaRepository<PostEntity, Long> {
    Page<PostEntity> findAllByUserEntity(UserEntity userEntity, Pageable pageable);
}
