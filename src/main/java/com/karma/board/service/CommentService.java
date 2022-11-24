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

    public void saveComment(UserAccountDto userAccountDto,CommentDto commentDto){
        userAccountRepository.findByUsername(userAccountDto.getUsername())
                .orElseThrow(()->{throw new MyException(
                        ErrorCode.USER_NOT_FOUND,
                        String.format("Username [%s] is not founded", userAccountDto.getUsername()));});
        Article article = articleRepository.findById(commentDto.getArticleId()).orElseThrow(()->{
            throw new MyException(
                    ErrorCode.ENTITY_NOT_FOUND,
                    String.format("Article with id [%s] is not founded",  commentDto.getArticleId()));});
        Comment comment = Comment.of(article, commentDto.getContent());
        // Save
        commentRepository.save(comment);
    }

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

    public void deleteComment(Long commentId){
        commentRepository.deleteById(commentId);
    }
}
