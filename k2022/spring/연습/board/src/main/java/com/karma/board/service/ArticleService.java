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
import com.karma.board.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
@Transactional
@RequiredArgsConstructor
public class ArticleService {

    private final UserAccountRepository userAccountRepository;
    private final ArticleRepository articleRepository;
    private final static int PAGINATION_BAR_LENGTH=5;

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
        return articleRepository
                .findById(articleId)
                .orElseThrow(()->{throw new MyException(
                        ErrorCode.ENTITY_NOT_FOUND,
                        String.format("Article with id [%s] not founded", articleId));});
    }

    @Transactional(readOnly = true)
    public ArticleWithCommentDto getArticleWithCommentDto(Long articleId){
        Article article = findById(articleId);
        ArticleDto articleDto = ArticleDto.from(article);
        Set<CommentDto> commentDtoSet = article.getComments().stream().map(CommentDto::from).collect(Collectors.toSet());
        UserAccountDto userAccountDto;
        // Case ⅰ) Article.userAccount == null
        if (article.getUserAccount() == null){
            String username = article.getCreatedBy();
            userAccountDto = UserAccountDto.from(
                    userAccountRepository
                            .findByUsername(username)
                            .orElseThrow(()->{throw new MyException(
                                    ErrorCode.USER_NOT_FOUND,
                                    String.format("Username [%s] is not founded", username));}));
        // Case ⅱ) Article.userAccount != null
        } else {
            userAccountDto = UserAccountDto.from(article.getUserAccount());
        }
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

    public List<Integer> getPaginationBarNumbers(int currentPage, int totalPage){
        int startPage = Math.max(0, currentPage-(PAGINATION_BAR_LENGTH/2));
        int endPage = Math.min(totalPage, startPage+PAGINATION_BAR_LENGTH);
        return IntStream.range(startPage, endPage).boxed().collect(Collectors.toList());
    }
}
