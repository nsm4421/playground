package com.karma.board.repository;

import com.karma.board.config.JpaConfig;
import com.karma.board.domain.Article;
import com.karma.board.domain.AuditingFields;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;

import java.util.List;
import static org.assertj.core.api.Assertions.assertThat;


@DisplayName("Jpa CRUD")
@Import(JpaConfig.class)
@DataJpaTest
class JpaTest {
    @Autowired private final ArticleRepository articleRepository;
    @Autowired private final CommentRepository commentRepository;

    public JpaTest(@Autowired ArticleRepository articleRepository, @Autowired CommentRepository commentRepository) {
        this.articleRepository = articleRepository;
        this.commentRepository = commentRepository;
    }

    @Test
    @DisplayName("SELECT ALL")
    void select_all(){
        //given → nothing

        //when → find all
        List<Article> articles = articleRepository.findAll();

        //then → not null
        assertThat(articles)
                .isNotNull();
    }

    @Test
    @DisplayName("INSERT")
    void insert(){
        //given → count
        long previousSize = articleRepository.count();
        Article recordToInsert = Article.of("new title", "new content", "new hashtags");

        //when → save new data
        List<Article> articles = articleRepository.findAll();
        articleRepository.save(recordToInsert);

        //then → count = previous count + 1
        assertThat(articleRepository.count())
                .isEqualTo(previousSize+1);
    }

    @Test
    @DisplayName("UPDATE")
    void update() {
        //given → record to update
        Article recordToUpdate = articleRepository.findById(1L).orElseThrow();

        //when → update data
        recordToUpdate.setTitle("updated title");
        recordToUpdate.setHashtags("updated hashtag");
        Article savedRecord = articleRepository.saveAndFlush(recordToUpdate);

        //then → check updated field
        assertThat(savedRecord)
                .hasFieldOrPropertyWithValue("title", "updated title")
                .hasFieldOrPropertyWithValue("hashtags", "updated hashtag");
    }

    @Test
    @DisplayName("DELETE")
    void delete() {
        //given → record to delete
        Article recordToDelete = articleRepository.findById(1L).orElseThrow();
        Long previousCount = articleRepository.count();

        //when → delete record
        articleRepository.delete(recordToDelete);

        //then → count = previous count - 1
        assertThat(articleRepository.count())
                .isEqualTo(previousCount-1);
    }
}