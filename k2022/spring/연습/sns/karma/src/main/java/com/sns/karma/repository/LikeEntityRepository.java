package com.sns.karma.repository;

import com.sns.karma.model.like.LikeEntity;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.UserEntity;
import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LikeEntityRepository extends JpaRepository<LikeEntity, Long> {
    Optional<LikeEntity> findByUserAndPost(UserEntity userEntity, PostEntity postEntity);

    @Query(value = "SELECT COUNT(*) FROM LikeEntity likeEntity WHERE likeEntity.post=:post")
    Long countByPost(@Param("post") PostEntity post);

}
