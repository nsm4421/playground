package com.sns.karma.repository;

import com.sns.karma.model.comment.CommentEntity;
import com.sns.karma.model.post.PostEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentEntityRepository extends JpaRepository<CommentEntity, Long> {
    Page<CommentEntity> findAllByPost(PostEntity postEntity, Pageable pageable);
}
