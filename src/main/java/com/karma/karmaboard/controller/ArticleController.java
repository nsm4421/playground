package com.karma.karmaboard.controller;

import com.karma.karmaboard.domain.type.SearchType;
<<<<<<< HEAD
import com.karma.karmaboard.repository.ArticleRepository;
=======
>>>>>>> 87de0747cf93fa3bce34cdb2b954a9b732cfd3c9
import com.karma.karmaboard.service.ArticleService;
import dto.response.ArticleCommentResponse;
import dto.response.ArticleResponse;
import dto.response.ArticleWithCommentsResponse;
<<<<<<< HEAD
import lombok.RequiredArgsConstructor;
=======
>>>>>>> 87de0747cf93fa3bce34cdb2b954a9b732cfd3c9
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
<<<<<<< HEAD
//private ArticleResponse test;
=======

    public ArticleController() {
        articleService = null;
    }
>>>>>>> 87de0747cf93fa3bce34cdb2b954a9b732cfd3c9

    @GetMapping
    public String articles(
            @RequestParam(required = false) SearchType searchType,
            @RequestParam(required = false) String searchKeyword,
<<<<<<< HEAD
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
=======
            @PageableDefault(size = 20, sort = "createAt", direction = Sort.Direction.DESC) Pageable pageable,
>>>>>>> 87de0747cf93fa3bce34cdb2b954a9b732cfd3c9
            ModelMap map
    ){
        map.addAttribute("articles",
                articleService
                        .searchArticlePage(searchType, searchKeyword, pageable)
<<<<<<< HEAD
                        .map(ArticleResponse::from)
        );
=======
                        .map(ArticleResponse::from));
>>>>>>> 87de0747cf93fa3bce34cdb2b954a9b732cfd3c9
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
