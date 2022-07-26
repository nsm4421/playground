package com.karma.karmaboard.repository;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.ArticleComment;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ActiveProfiles;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("JPA Connection Test")
@Import(com.karma.projectboard.config.JpaConfig.class)
@DataJpaTest
class JpaRepositoryTest {


    private final ArticleRepository articleRepository;
    private final ArticleCommentRepository articleCommentRepository;

    public JpaRepositoryTest(@Autowired ArticleRepository articleRepository,  @Autowired ArticleCommentRepository articleCommentRepository) {
        this.articleRepository = articleRepository;
        this.articleCommentRepository = articleCommentRepository;
    }

    @DisplayName("Select Query Test")
    @Test
    void select_query_test(){
        List<Article> articleList = articleRepository.findAll();
        assertThat(articleList).isNotNull().hasSize(1000);
        List<ArticleComment> articleCommentList = articleCommentRepository.findAll();
        assertThat(articleCommentList).isNotNull().hasSize(1000);
    }
    @Disabled("ToDo : 왜 어러나지...???")
    @DisplayName("Insert Query Test")
    @Test
    void insert_query_test(){
        long previousCnt = articleRepository.count();
        Article newArticle = Article.of("new article", "new content", "test");
        articleRepository.save(newArticle);
        assertThat(articleRepository.count()).isEqualTo(previousCnt+1);
    }
}