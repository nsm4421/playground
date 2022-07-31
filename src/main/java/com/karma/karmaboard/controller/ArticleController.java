package com.karma.karmaboard.controller;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.type.SearchType;
import com.karma.karmaboard.service.ArticleService;
import com.karma.karmaboard.service.PaginationService;
import dto.response.ArticleCommentResponse;
import dto.response.ArticleResponse;
import dto.response.ArticleWithCommentsResponse;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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
    private final PaginationService paginationService;

    @GetMapping
    public String articles(
            @RequestParam(required = false) SearchType searchType,
            @RequestParam(required = false) String searchKeyword,
            @PageableDefault(size = 15, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
            ModelMap map
    ){
        Page<ArticleResponse> articleResponsePage = articleService
                .searchArticlePage(searchType, searchKeyword, pageable)
                .map(ArticleResponse::from);

        map.addAttribute("articles", articleResponsePage);
        int currentPage = pageable.getPageNumber();
        int totalPages = articleResponsePage.getTotalPages();
        List<Integer> pageList = paginationService.getPagination(currentPage, totalPages);

        map.addAttribute("articles", articleResponsePage);
        map.addAttribute("pageList", pageList);

        return "articles/index";
    }

    @GetMapping("/{articleId}")
    public String article(@PathVariable Long articleId, ModelMap map){
        ArticleWithCommentsResponse articleWithCommentsResponse = ArticleWithCommentsResponse.from(articleService.searchArticleById(articleId));
        Long totalArticleCount = articleService.getArticleCount();
        map.addAttribute("article",articleWithCommentsResponse);
        map.addAttribute("articleComments",articleWithCommentsResponse.articleCommentsResponse());
        map.addAttribute("totalArticleCount",totalArticleCount);
        return "articles/detail";
    }
}
