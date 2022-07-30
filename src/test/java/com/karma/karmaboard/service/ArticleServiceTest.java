package com.karma.karmaboard.service;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleRepository;
import dto.ArticleDto;
import dto.ArticleUpdateDto;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.BDDMockito;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.*;

@DisplayName("[Service] Article")
@ExtendWith(MockitoExtension.class)
class ArticleServiceTest {

    @InjectMocks private ArticleService sut; // system under test
    @Mock private ArticleRepository articleRepository;

    // 검색기능
    @Test
    @DisplayName("[Service] Search articles")
    void searchArticlesTest(){
        Page<ArticleDto> articlesDtoPage = sut.searchArticlePage(SearchType.TITLE, "search keyword");
        assertThat(articlesDtoPage).isNotNull();
    }
    // 단건 검색기능
    @Test
    @DisplayName("[Service] Search article by id")
    void searchArticleByIdTest(){
        ArticleDto articleDto = sut.searchArticleById(1);
        assertThat(articleDto).isNotNull();
    }

    @Test
    @DisplayName("[Service] Saving Article")
    void saveArticleTest(){
        ArticleDto articleDto = ArticleDto.of("test title", "test content", "test hashtag", LocalDateTime.now(), "karma");
        given(articleRepository.save(any(Article.class))).willReturn(null);
        sut.saveArticle(articleDto);
        then(articleRepository).should().save(any(Article.class));
    }

    @Test
    @DisplayName("[Service] Update Article")
    void updateArticleTest(){
        ArticleUpdateDto articleUpdateDto = ArticleUpdateDto.of("test title", "test content", "test hashtag");
        given(articleRepository.save(any(Article.class))).willReturn(null);
        sut.updateArticle(1, articleUpdateDto);
        then(articleRepository).should().save(any(Article.class));
    }

    @Test
    @DisplayName("[Service] Delete Article")
    void deleteArticleTest(){
        willDoNothing().given(articleRepository).delete(any(Article.class));
        sut.deleteArticle(1);
        then(articleRepository).should().delete(any(Article.class));
    }
}