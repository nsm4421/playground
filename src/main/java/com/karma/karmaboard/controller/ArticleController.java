package com.karma.karmaboard.controller;

import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.repository.ArticleRepository;
import com.karma.karmaboard.service.ArticleService;
import dto.response.ArticleCommentResponse;
import dto.response.ArticleResponse;
import dto.response.ArticleWithCommentsResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/articles")
public class ArticleController {

    private final ArticleService articleService;
//private ArticleResponse test;

    @GetMapping
    public String articles(
            @RequestParam(required = false) SearchType searchType,
            @RequestParam(required = false) String searchKeyword,
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
            ModelMap map
    ){
        map.addAttribute("articles",
                articleService
                        .searchArticlePage(searchType, searchKeyword, pageable)
                        .map(ArticleResponse::from)
        );
        return "articles/index";
    }

    @GetMapping("/{articleId}")
    public String article(@PathVariable Long articleId, ModelMap map){
        ArticleWithCommentsResponse articleWithCommentsResponse = ArticleWithCommentsResponse.from(articleService.searchArticleById(articleId));
        map.addAttribute("article",articleWithCommentsResponse);
        map.addAttribute("articleComments",articleWithCommentsResponse.articleCommentsResponse());
        return "articles/detail";
    }
}
