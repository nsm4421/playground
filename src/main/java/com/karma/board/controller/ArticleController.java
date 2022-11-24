package com.karma.board.controller;

import com.karma.board.controller.request.WriteArticleRequest;
import com.karma.board.controller.response.ArticleResponse;
import com.karma.board.controller.response.ArticlesResponse;
import com.karma.board.controller.response.CommentsResponse;
import com.karma.board.domain.Article;
import com.karma.board.domain.SearchType;
import com.karma.board.domain.dto.ArticleDto;
import com.karma.board.domain.dto.ArticleWithCommentDto;
import com.karma.board.service.ArticleService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/articles")
@RequiredArgsConstructor
public class ArticleController {
    private final ArticleService articleService;
    @GetMapping
    public String articles(
            @RequestParam(required = false) SearchType searchType,
            @RequestParam(required = false) String keyword,
            @PageableDefault(size=20, sort = "createdAt", direction = Sort.Direction.DESC)Pageable pageable,
            ModelMap map){
        Page<ArticleDto> articleDtoPage = articleService.searchArticleDtoPage(searchType, keyword, pageable);
        List<Integer> pagination = articleService.getPaginationBarNumbers(pageable.getPageNumber(), articleDtoPage.getTotalPages());
        map.addAttribute("articles", articleDtoPage.map(ArticlesResponse::from));
        map.addAttribute("pagination", pagination);
        map.addAttribute("searchTypes", SearchType.values());
        return "article/index";
    }

    @GetMapping("/{articleId}")
    public String article(@PathVariable Long articleId, ModelMap map){
        ArticleWithCommentDto dto = articleService.getArticleWithCommentDto(articleId);
        map.addAttribute("articleId", articleId);
        map.addAttribute("article", ArticleResponse.from(dto));
        map.addAttribute("comments", CommentsResponse.from(dto));
        return "article/detail/index";
    }

    @GetMapping("/write")
    public String write(){
        return "article/write/index";
    }
    @PostMapping("/write")
    public String saveArticle(WriteArticleRequest req){
        Article article = WriteArticleRequest.to(req);
        articleService.saveArticle(article);
        return "redirect:/articles";
    }
}
