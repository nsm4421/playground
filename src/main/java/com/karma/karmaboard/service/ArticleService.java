package com.karma.karmaboard.service;

import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleRepository;
import dto.ArticleDto;
import dto.ArticleUpdateDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// TODO
@RequiredArgsConstructor
@Service
@Transactional
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public Page<ArticleDto> searchArticlePage(SearchType title, String search_keyword){
        return Page.empty();
    }
    @Transactional(readOnly = true)
    public ArticleDto searchArticleById(int i) {
        return null;
    }

    public void saveArticle(ArticleDto articleDto) {
    }

    public void updateArticle(long articleId, ArticleUpdateDto articleUpdateDto) {

    }

    public void deleteArticle(int i) {
    }
}
