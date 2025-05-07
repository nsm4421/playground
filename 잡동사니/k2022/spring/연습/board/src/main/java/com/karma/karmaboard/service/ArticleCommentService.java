package com.karma.karmaboard.service;

import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleCommentRepository;
import com.karma.karmaboard.repository.ArticleRepository;
import dto.ArticleCommentDto;
import dto.ArticleDto;
import dto.ArticleUpdateDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

// TODO
@RequiredArgsConstructor
@Service
@Transactional
public class ArticleCommentService {

    private final ArticleCommentRepository articleCommentRepository;

    @Transactional(readOnly = true)
    public List<ArticleCommentDto> getArticleCommentsByArticleId(Long articleId){
        return List.of();
    }

    public void saveArticleComment(Long articleId, ArticleCommentDto articleCommentDto) {
    }
}
