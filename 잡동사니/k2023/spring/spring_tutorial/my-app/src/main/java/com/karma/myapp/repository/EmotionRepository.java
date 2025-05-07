package com.karma.myapp.repository;

import com.karma.myapp.domain.entity.ArticleEntity;
import com.karma.myapp.domain.entity.EmotionEntity;
import com.karma.myapp.domain.entity.UserAccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface EmotionRepository extends JpaRepository<EmotionEntity, Long> {
    @Transactional(readOnly = true)
    Optional<EmotionEntity> findByUserAndArticle(UserAccountEntity user, ArticleEntity article);
    @Query("select e.emotion, count(e) from EmotionEntity e where e.article = :article group by e.emotion")
    @Transactional(readOnly = true)
    List<Object[]> getCountMap(@Param("article") ArticleEntity article);
}
