package com.karma.board.service;

import com.karma.board.domain.Article;
import com.karma.board.domain.Comment;
import com.karma.board.domain.UserAccount;
import com.karma.board.domain.dto.CommentDto;
import com.karma.board.domain.dto.UserAccountDto;
import com.karma.board.exception.ErrorCode;
import com.karma.board.exception.MyException;
import com.karma.board.repository.ArticleRepository;
import com.karma.board.repository.CommentRepository;
import com.karma.board.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class CommentService {
    private final UserAccountRepository userAccountRepository;
    private final ArticleRepository articleRepository;
    private final CommentRepository commentRepository;

    @Transactional(readOnly = true)
    public List<Comment> searchComment(Long articleId){
        return List.of();
    }

    @Transactional
    public void saveComment(UserAccountDto userAccountDto,CommentDto commentDto){
        // Dto → Entity
        UserAccount userAccount = userAccountRepository
                .findByUsername(userAccountDto.getUsername())
                        .orElseThrow(()->{throw new MyException(
                                ErrorCode.USER_NOT_FOUND,
                                String.format("Username [%s] is not founded", userAccountDto.getUsername()));});
        Article article = articleRepository.getReferenceById(commentDto.getArticleId());
        Comment comment = Comment.of(article, commentDto.getContent());
        // Save
        commentRepository.save(comment);
    }

    @Transactional
    public void updateComment(Long commentId, String content){
        Comment comment = commentRepository
                .findById(commentId)
                .orElseThrow(()->{throw new MyException(
                        ErrorCode.ENTITY_NOT_FOUND,
                        String.format("Comment with [%s] is not founded", commentId)
                );});
        comment.setContent(content);
        commentRepository.save(comment);
    }

    @Transactional
    public void deleteComment(Long commentId){
        commentRepository.deleteById(commentId);
    }
}
