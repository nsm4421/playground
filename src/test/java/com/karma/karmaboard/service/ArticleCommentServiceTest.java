package com.karma.karmaboard.service;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.ArticleComment;
import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleCommentRepository;
import com.karma.karmaboard.repository.ArticleRepository;
import dto.ArticleCommentDto;
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
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.*;

@DisplayName("[Service] ArticleComment")
@ExtendWith(MockitoExtension.class)
class ArticleCommentServiceTest {

    @InjectMocks private ArticleCommentService sut; // system under test
    @Mock private ArticleRepository articleRepository;
    @Mock private ArticleCommentRepository articleCommentRepository;

    // 검색기능
//    @Test
//    @DisplayName("[Service] Search article comments by article id")
//    void searchArticleCommentsTest(){
//        Long articleId = 1L;
//        Article article = Article.of("test title", "test content", "test hashtag");
//        given(articleRepository.findById(articleId))
//                .willReturn(Optional.of(article));
//        List<ArticleCommentDto> articleCommentsDto = sut.getArticleCommentsByArticleId(articleId);
//        assertThat(articleCommentsDto).isNotNull();
//        then(articleRepository).should().findById(articleId);
//    }
}