package com.karma.community.service;

import com.karma.community.exception.CustomError;
import com.karma.community.exception.CustomErrorCode;
import com.karma.community.model.dto.ArticleCommentDto;
import com.karma.community.model.entity.ArticleComment;
import com.karma.community.repository.ArticleCommentRepository;
import com.karma.community.repository.ArticleRepository;
import com.karma.community.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@RequiredArgsConstructor
@Transactional
public class ArticleCommentService {
    private final UserAccountRepository userAccountRepository;
    private final ArticleRepository articleRepository;
    private final ArticleCommentRepository articleCommentRepository;

    @Transactional(readOnly = true)
    public Page<ArticleCommentDto> findCommentsByArticleId(Long articleId, Pageable pageable) {
        return articleCommentRepository
                .findByArticle_ArticleId(articleId, pageable)
                .map(ArticleCommentDto::from);
    }

    public void saveComment(ArticleCommentDto dto, String loginUsername){
        // 댓글 Entity
        ArticleComment articleComment = composeArticleComment(dto, loginUsername);
        // Parent Comment 저장하는 경우
        if (dto.parentCommentId() == null){
            articleCommentRepository.save(articleComment);
        // Child Comment(대댓글) 저장하는 경우
        } else {
            ArticleComment parentComment = findByCommentById(dto.parentCommentId());
            parentComment.addChildComment(articleComment);
        }
    }

    public void modifyComment(Long articleCommentId, String content, String loginUsername){
        // 댓글 Entity
        ArticleComment articleComment = findByCommentById(articleCommentId);
        // 로그인한 유저와 댓글 작성자가 일치하는지 확인
        if (!articleComment.getUserAccount().getUsername().equals(loginUsername)){
            throw CustomError.of(CustomErrorCode.UNAUTHORIZED_ACCESS);
        }
        // 수정 및 저장
        articleComment.setContent(content);
        articleCommentRepository.save(articleComment);
    }

    public void deleteComment(Long articleCommentId, String loginUsername){
        // 댓글 Entity 생성
        ArticleComment articleComment = findByCommentById(articleCommentId);
        // 로그인한 유저와 댓글 작성자가 일치하는지 확인
        if (!articleComment.getUserAccount().getUsername().equals(loginUsername)){
            throw CustomError.of(CustomErrorCode.UNAUTHORIZED_ACCESS);
        }
        // 삭제
        articleCommentRepository.deleteById(articleCommentId);
    }

    private ArticleComment findByCommentById(Long articleCommentId){
        return articleCommentRepository.findById(articleCommentId).orElseThrow(()->{
            throw CustomError.of(CustomErrorCode.ARTICLE_COMMENT_NOT_FOUND);
        });
    }

    /**
     * ArticleComment Entity 생성하기
     * @param articleCommentDto 댓글 Dto
     * @param loginUsername 로그인한 유저의 유저명
     * @return 댓글 Entity
     */
    private ArticleComment composeArticleComment(ArticleCommentDto articleCommentDto, String loginUsername){
        return ArticleComment.of(
                articleRepository.findById(articleCommentDto.articleId()).orElseThrow(()->{
                    throw CustomError.of(CustomErrorCode.ARTICLE_NOT_FOUND);
                }),
                userAccountRepository.findById(loginUsername).orElseThrow(()->{
                    throw CustomError.of(CustomErrorCode.USER_NOT_FOUND);
                }),
                articleCommentDto.content()
        );
    }
}
