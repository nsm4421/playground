package com.karma.board.service;

import com.karma.board.domain.Article;
import com.karma.board.domain.SearchType;
import com.karma.board.domain.dto.ArticleDto;
import com.karma.board.domain.dto.ArticleWithCommentDto;
import com.karma.board.domain.dto.CommentDto;
import com.karma.board.domain.dto.UserAccountDto;
import com.karma.board.exception.ErrorCode;
import com.karma.board.exception.MyException;
import com.karma.board.repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ArticleService {
    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public Page<ArticleDto> searchArticleDtoPage(SearchType searchType, String keyword, Pageable pageable){
        if (keyword == null || keyword.isBlank()){
            return articleRepository.findAll(pageable).map(ArticleDto::from);
        }
        return switch (searchType){
            case TITLE->articleRepository.findByTitleContaining(keyword, pageable).map(ArticleDto::from);
            case USERNAME->articleRepository.findByUserAccount_UsernameContaining(keyword, pageable).map(ArticleDto::from);
            case HASHTAG->articleRepository.findByHashtags(keyword, pageable).map(ArticleDto::from);
            case CONTENT->articleRepository.findByContentContaining(keyword, pageable).map(ArticleDto::from);
            default -> articleRepository.findAll(pageable).map(ArticleDto::from);
        };
    }
    @Transactional(readOnly = true)
    private Article findById(Long articleId){
        return  articleRepository
                .findById(articleId)
                .orElseThrow(()->{throw new MyException(
                        ErrorCode.ENTITY_NOT_FOUND,
                        String.format("Article with id [%s] not founded", articleId));});
    }

    @Transactional(readOnly = true)
    public ArticleWithCommentDto getArticleWithCommentDto(Long articleId){
        Article article = findById(articleId);
        ArticleDto articleDto = ArticleDto.from(article);
        UserAccountDto userAccountDto = UserAccountDto.from(article.getUserAccount());
        Set<CommentDto> commentDtoSet = article.getComments().stream().map(CommentDto::from).collect(Collectors.toSet());
        return ArticleWithCommentDto.from(articleDto, userAccountDto, commentDtoSet);
    }

    public ArticleDto saveArticle(Article article) {
        Article savedArticle = articleRepository.save(article);
        return ArticleDto.from(savedArticle);
    }

    public ArticleDto updateArticle(Long articleId, ArticleDto articleDto){
        if (articleDto.getTitle() == null){throw new MyException(ErrorCode.INVALID_PARAMETER, "Title is null");}
        if (articleDto.getContent() == null){throw new MyException(ErrorCode.INVALID_PARAMETER, "Content is null");}
        Article article = findById(articleId);
        article.setTitle(articleDto.getTitle());
        article.setContent(articleDto.getContent());
        article.setHashtags(articleDto.getHashtags());
        return ArticleDto.from(articleRepository.save(article));
    }

    public void deleteArticle(Long articleId){
        articleRepository.delete(findById(articleId));
    }
}
