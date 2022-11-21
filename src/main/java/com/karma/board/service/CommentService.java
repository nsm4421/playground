package com.karma.board.service;

import com.karma.board.domain.Comment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CommentService {
    @Transactional(readOnly = true)
    public List<Comment> searchComment(Long articleId){
        return List.of();
    }
}
