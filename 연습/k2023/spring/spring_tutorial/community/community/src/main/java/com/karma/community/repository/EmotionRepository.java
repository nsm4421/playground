package com.karma.community.repository;

import com.karma.community.model.entity.Article;
import com.karma.community.model.entity.Emotion;
import com.karma.community.model.entity.UserAccount;
import com.karma.community.model.util.EmotionType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
public interface EmotionRepository extends JpaRepository<Emotion, Long> {

    Optional<Emotion> findByArticleAndUserAccount(Article article, UserAccount userAccount);

    @Query(value = """
            SELECT COUNT(*)
            FROM Emotion entity
            WHERE entity.article = :article AND
            entity.emotionType = :emotionType
            """)
    long countEmotionByArticleAndType(
            @Param("article") Article article,
            @Param("emotionType") EmotionType emotionType
    );

    @Transactional
    @Modifying
    @Query("DELETE Emotion entity WHERE entity.article = :article")
    void deleteAllByArticle(@Param("article") Article article);
}
