package com.karma.community.service;

import com.karma.community.exception.CustomError;
import com.karma.community.exception.CustomErrorCode;
import com.karma.community.model.dto.ArticleDto;
import com.karma.community.model.entity.Article;
import com.karma.community.model.entity.UserAccount;
import com.karma.community.model.util.SearchType;
import com.karma.community.repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
@RequiredArgsConstructor
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public ArticleDto findByArticleId(Long articleId) {
        return ArticleDto.from(articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomError.of(CustomErrorCode.ARTICLE_NOT_FOUND);
        }));
    }

    @Transactional(readOnly = true)
    public Page<ArticleDto> findAll(Pageable pageable) {
        return articleRepository.findAll(pageable).map(ArticleDto::from);
    }

    @Transactional(readOnly = true)
    public Page<ArticleDto> searchArticle(SearchType searchType, String searchWord, Pageable pageable) {
        // 검색어가 유효하지 않은 경우
        if (searchWord == null || searchWord.isBlank()) {
            throw CustomError.of(CustomErrorCode.INVALID_INPUT, "검색어가 없거나 빈칸입니다");
        }
        // 검색 유형에 따라 처리
        Page<Article> articles = switch (searchType) {
            case TITLE -> articleRepository.findByTitleContaining(searchWord, pageable);
            case CONTENT -> articleRepository.findByContentContaining(searchWord, pageable);
            case NICKNAME -> articleRepository.findByUserAccount_NicknameContaining(searchWord, pageable);
        };
        // return page of dto
        return articles.map(ArticleDto::from);
    }

    public ArticleDto writeArticle(ArticleDto articleDto, UserAccount loginUser) {
        // 게시글 Entity 생성
        Article article = ArticleDto.toEntity(
                loginUser,
                articleDto.title(),
                articleDto.content(),
                articleDto.hashtags()
        );
        // 저장 & return dto
        return ArticleDto.from(articleRepository.save(article));
    }

    public ArticleDto modifyArticle(ArticleDto modifyRequest, UserAccount loginUser) {
        // 존재하는 게시물인지 확인
        Article article = articleRepository.findById(modifyRequest.articleId()).orElseThrow(() -> {
            throw CustomError.of(CustomErrorCode.ARTICLE_NOT_FOUND);
        });
        // 게시글 작성자와 수정요청한 유저가 동일한지 확인
        if (!article.getUserAccount().getUsername().equals(loginUser.getUsername())) {
            throw CustomError.of(CustomErrorCode.UNAUTHORIZED_ACCESS);
        }
        // 게시글 수정
        article.setTitle(modifyRequest.title());
        article.setContent(modifyRequest.content());
        article.setContent(modifyRequest.content());
        article.setHashtags(modifyRequest.hashtags());
        // 저장 & return dto
        return ArticleDto.from(articleRepository.save(article));
    }

    public void deleteArticle(Long articleId, UserAccount loginUser) {
        // 존재하는 게시물인지 확인
        Article article = articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomError.of(CustomErrorCode.ARTICLE_NOT_FOUND);
        });
        // 작성자와 삭제 요청한 유저가 동일한지 확인
        if (!article.getUserAccount().getUsername().equals(loginUser.getUsername())) {
            throw CustomError.of(CustomErrorCode.UNAUTHORIZED_ACCESS);
        }
        // 삭제
        articleRepository.deleteById(articleId);
    }
}
