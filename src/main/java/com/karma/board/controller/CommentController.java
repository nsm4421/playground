package com.karma.board.controller;

import com.karma.board.repository.ArticleRepository;
import com.karma.board.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@Controller
@RequestMapping("/comment")
public class CommentController {
    private final ArticleRepository articleRepository;
    private final CommentRepository commentRepository;

    public void searchComment(){

    }

}
