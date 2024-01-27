package com.karma.myapp.repository;

import com.karma.myapp.domain.entity.ArticleCommentEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Transactional
public interface ArticleCommentRepository extends JpaRepository<ArticleCommentEntity, Long> {

    // get parent comments
    @Transactional(readOnly = true)
    @Query("select a from ArticleCommentEntity a where a.article.id = :articleId and a.parentCommentId = null")
    Page<ArticleCommentEntity> getParentCommentsByArticleId(@Param("articleId") Long articleId, Pageable pageable);

    // get child comments
    @Query("select a from ArticleCommentEntity a where a.parentCommentId = :parentId")
    @Transactional(readOnly = true)
    Page<ArticleCommentEntity> getChildCommentsByParentCommentId(@Param("parentId") Long parentId, Pageable pageable);

    // delete all child comments
    @Modifying
    @Query("delete from ArticleCommentEntity a where a.parentCommentId = :parentId")
    void deleteChildCommentsByParentCommentId(@Param("parentId") Long parentCommentId);
}
