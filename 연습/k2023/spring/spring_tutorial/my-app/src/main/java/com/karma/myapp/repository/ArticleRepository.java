package com.karma.myapp.repository;

import com.karma.myapp.domain.entity.ArticleEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface ArticleRepository extends JpaRepository<ArticleEntity, Long> {
    @Transactional(readOnly = true) Optional<ArticleEntity> findById(Long id);
    @Transactional(readOnly = true) Page<ArticleEntity> findAll(Pageable pageable);
    @Transactional(readOnly = true) Page<ArticleEntity> findByCreatedBy(String createdBy, Pageable pageable);
    @Transactional(readOnly = true) Page<ArticleEntity> findByTitleContaining(String title, Pageable pageable);
    @Transactional(readOnly = true) Page<ArticleEntity> findByContentContaining(String content, Pageable pageable);
    @Transactional(readOnly = true) Page<ArticleEntity> findByHashtags(String hashtag, Pageable pageable);
}
