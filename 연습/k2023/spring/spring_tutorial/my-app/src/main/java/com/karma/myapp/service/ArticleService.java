package com.karma.myapp.service;

import com.karma.myapp.domain.constant.SearchType;
import com.karma.myapp.domain.dto.ArticleDto;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.domain.entity.ArticleEntity;
import com.karma.myapp.domain.entity.UserAccountEntity;
import com.karma.myapp.exception.CustomErrorCode;
import com.karma.myapp.exception.CustomException;
import com.karma.myapp.repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;


@Service
@RequiredArgsConstructor
@Transactional
public class ArticleService {
    private final ArticleRepository articleRepository;

    /**
     * 게시글 단건 조회
     *
     * @param articleId 조회할 게시글 id
     * @return 게시글 Dto
     */
    @Transactional(readOnly = true)
    public ArticleDto getArticle(Long articleId) {
        return ArticleDto.from(articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomException.of(
                    CustomErrorCode.ENTITY_NOT_FOUND,
                    String.format("Article with id %s not exists", articleId));
        }));
    }

    /**
     * 게시글 다건 조회
     *
     * @param searchType : 검색유형
     * @param searchText : 검색어
     * @param pageable
     * @return Page of article dto
     */
    @Transactional(readOnly = true)
    public Page<ArticleDto> getArticles(SearchType searchType, String searchText, Pageable pageable) {
        if (searchType == null || searchText == null) {
            return articleRepository.findAll(pageable).map(ArticleDto::from);
        }
        return (switch (searchType) {
            case TITLE -> articleRepository.findByTitleContaining(searchText, pageable);
            case CONTENT -> articleRepository.findByContentContaining(searchText, pageable);
            case USER -> articleRepository.findByCreatedBy(searchText, pageable);
            case HASHTAG -> articleRepository.findByHashtags(searchText, pageable);
        }).map(ArticleDto::from);
    }

    /**
     * 게시글 작성
     *
     * @param principal 로그인한 유저의 인증정보
     * @param title     제목
     * @param content   본문
     * @return
     */
    public ArticleDto writeArticle(CustomPrincipal principal, String title, String content, Set<String> hashtags) {
        return ArticleDto.from(articleRepository.save(
                ArticleEntity.of(
                        UserAccountEntity.from(principal),
                        title,
                        content,
                        hashtags
                )));
    }

    /**
     * 게시글 수정
     *
     * @param principal 로그인한 유저의 인증정보
     * @param articleId 수정할 게시글
     * @param title     수정할 제목
     * @param content   수정할 본문
     * @return 게시글 Dto
     */
    public ArticleDto modifyArticle(CustomPrincipal principal, Long articleId, String title, String content, Set<String> hashtags) {
        // get article
        ArticleEntity article = articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomException.of(CustomErrorCode.ENTITY_NOT_FOUND, String.format("Article with id %s not exists", articleId));
        });
        // check login user is author of article
        UserAccountEntity user = UserAccountEntity.from(principal);
        if (!article.getUser().equals(user)) {
            throw CustomException.of(CustomErrorCode.NOT_GRANT, "Only author can modify article");
        }
        article.setTitle(title);
        article.setContent(content);
        article.setHashtags(hashtags);
        return ArticleDto.from(articleRepository.save(article));
    }

    /**
     * 게시글 삭제
     *
     * @return 게시글 Dto
     */
    public void deleteArticle(CustomPrincipal principal, Long articleId) {
        // get article
        ArticleEntity article = articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomException.of(CustomErrorCode.ENTITY_NOT_FOUND, String.format("Article with id %s not exists", articleId));
        });
        // check login user is author of article
        UserAccountEntity user = UserAccountEntity.from(principal);
        if (!article.getUser().equals(user)) {
            throw CustomException.of(CustomErrorCode.NOT_GRANT, "Only author can modify article");
        }
        articleRepository.deleteById(articleId);
    }
}