package com.karma.board.service;

import com.karma.board.domain.Article;
import com.karma.board.domain.dto.ArticleDto;
import com.karma.board.repository.ArticleRepository;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.*;

@DisplayName("Article Service")
@ExtendWith(MockitoExtension.class)
class ArticleServiceTest {

    @InjectMocks private ArticleService articleService;
    @Mock private ArticleRepository articleRepository;


    @Disabled("TODO")
    @DisplayName("Search Articles")
    @Test
    void searchTest(){
        // TODO
        //given - Search Parameters

        //when - Get Article List
        Page<ArticleDto> articleDtoPage = articleService.getArticlePage();

        //then - Check Not Null
        assertThat(articleDtoPage).isNotNull();
    }

    @Disabled("TODO")
    @DisplayName("Search Article")
    @Test
    void searchArticle(){
        // TODO
        //given - Article Id

        //when - Get Article

        //then - Check Not Null
    }

    @DisplayName("Save Article")
    @Test
    void saveArticle(){
        //given - ArticleDto To Save
        ArticleDto articleDto = ArticleDto.of("save test title",  "save test title", "save test hashtag",
                LocalDateTime.now(), "save test createdBy");
        given(articleRepository.save(any(Article.class))).willReturn(null);
        //when - Save Article Dto
        articleService.saveArticle(articleDto);
        //then - Check Saved
        then(articleRepository).should().save(any(Article.class));
    }

    @DisplayName("Update Article")
    @Test
    void updateArticle(){
        //given - Nothing

        //when - Update Article Dto
        articleService.updateArticle(
                1L,
                ArticleDto.of("update test title", "update test content", "update test hashtags")
        );
        //then - Check Saved
        then(articleRepository).should().save(any(Article.class));
    }

    @DisplayName("Delete Article")
    @Test
    void deleteArticle(){
        //given - Nothing
        willDoNothing().given(articleRepository).delete(any(Article.class));
        //when - Delete Article Dto
        articleService.deleteArticle(1L);
        //then - Check Deleted
        then(articleRepository).should().delete(any(Article.class));
    }
}