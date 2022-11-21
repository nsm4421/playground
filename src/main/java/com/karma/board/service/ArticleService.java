package com.karma.board.service;

import com.karma.board.domain.dto.ArticleDto;
import com.karma.board.repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class ArticleService {
    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public Page<ArticleDto> getArticlePage(){
        return Page.empty();
    }

    @Transactional(readOnly = true)
    public ArticleDto getArticle(){
        return null;
    }

    public void saveArticle(ArticleDto articleDto) {

    }

    public void updateArticle(Long articleId, ArticleDto articleDto){

    }

    public void deleteArticle(Long articleId){

    }

}
