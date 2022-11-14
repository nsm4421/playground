package com.karma.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/articles")
public class ArticleController {
    @GetMapping
    public String articles(ModelMap map){
        map.addAttribute("articles", List.of());    // TODO - send pageable of article
        return "article/index";
    }

    @GetMapping("/{articleId}")
    public String article(@PathVariable Long articleId, ModelMap map){
        map.addAttribute("article", null);  // TODO
        map.addAttribute("comments", List.of());
        return "article/detail/index";
    }
}
