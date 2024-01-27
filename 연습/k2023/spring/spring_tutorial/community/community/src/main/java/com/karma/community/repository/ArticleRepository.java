package com.karma.community.repository;

import com.karma.community.model.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    Page<Article> findAll(Pageable pageable);
    Page<Article> findByTitleContaining(String searchWord, Pageable pageable);
    Page<Article> findByContentContaining(String searchWord, Pageable pageable);
    Page<Article> findByUserAccount_NicknameContaining(String searchWord, Pageable pageable);
}
