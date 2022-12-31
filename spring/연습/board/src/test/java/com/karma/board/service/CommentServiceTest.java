package com.karma.board.service;

import com.karma.board.domain.Article;
import com.karma.board.domain.Comment;
import com.karma.board.repository.ArticleRepository;
import com.karma.board.repository.CommentRepository;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentMatchers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.then;


@DisplayName("Comment Service")
@ExtendWith(MockitoExtension.class)
class CommentServiceTest {
    @InjectMocks
    private CommentService commentService;
    @Mock
    private ArticleRepository articleRepository;
    @Mock
    private CommentRepository commentRepository;

    @DisplayName("Search Comment By Article Id")
    @Test
    void searchCommentByArticleId(){
        //given - Article Id
        given(articleRepository.findById(1L))
                .willReturn(Optional.of(Article.of("test title","test content","test hashtag")));

        //when - Get Comment List
        List<Comment> commentList = commentService.searchComment(1L);

        //then - Check Not Null
        assertThat(commentList).isNotNull();
        then(articleRepository).should().findById(1L);
    }

    @Disabled("TODO")
    @DisplayName("Save Comment")
    @Test
    void saveTest(){
        //TODO
    }
}