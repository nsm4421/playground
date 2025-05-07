package com.karma.karmaboard.service;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleRepository;
import com.karma.karmaboard.repository.querydsl.ArticleRepositoryCustomImpl;
import dto.ArticleDto;
import dto.ArticleUpdateDto;
import dto.ArticleWithCommentsDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityNotFoundException;
import java.util.List;

// TODO
@Slf4j
@RequiredArgsConstructor
@Service
@Transactional
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public Page<ArticleDto> searchArticlePage(SearchType searchType, String searchKeyword, Pageable pageable){
        //      Page<Article>
        Page<Article> articlePage;
        if (searchKeyword==null || searchKeyword.isBlank()){
            articlePage = articleRepository.findAll(pageable);
        } else {
            articlePage = switch (searchType){
                case ID -> articleRepository.findByUserAccount_UserIdContaining(searchKeyword, pageable);
                case TITLE -> articleRepository.findByTitleContaining(searchKeyword, pageable);
                case CONTENT -> articleRepository.findByContentContaining(searchKeyword, pageable);
                case HASHTAG -> articleRepository.findByHashtag(searchKeyword, pageable);
            };
        }
        //      Page<Article> -> Page<ArticleDto>
        return articlePage.map(ArticleDto::from);
    }
    @Transactional(readOnly = true)
    public ArticleWithCommentsDto searchArticleById(Long articleId) {
        return articleRepository
                .findById(articleId)
                .map(ArticleWithCommentsDto::from)
                .orElseThrow(()-> new EntityNotFoundException("ERROR - NO ARTICLE"));
    }

    public void saveArticle(ArticleDto articleDto) {
        articleRepository.save(articleDto.toEntity());
    }

    public void updateArticle(ArticleDto articleDto) {
        try{
            Article articleToUpdate = articleRepository.getReferenceById(articleDto.id());
            if (articleDto.title() != null){
                articleToUpdate.setTitle(articleDto.title());
            }
            if (articleDto.content() != null){
                articleToUpdate.setTitle(articleDto.content());
            }
            articleToUpdate.setHashtag(articleDto.hashtag());
//            articleRepository.save(articleToUpdate);  // <- unneccessarry
        } catch (EntityNotFoundException e){
            log.error("Error - Entity not found - ArticleDto : {}", e);
        };
    }

    public void deleteArticleById(Long articleId) {
        articleRepository.deleteById(articleId);
    }

    public long getArticleCount() {
        return articleRepository.count();
    }

    @Transactional(readOnly = true)
    public Page<ArticleDto> searchArticleViaHashtag(String hashtag, Pageable pageable){
        if (hashtag==null || hashtag.isBlank()){
            return Page.empty(pageable);
        }
        return articleRepository.findByHashtag(hashtag,pageable).map(ArticleDto::from);
    }

    @Transactional(readOnly = true)
    public List<String> getAllHashtags(){
        return articleRepository.findAllDistinctHashtag();
    }

}