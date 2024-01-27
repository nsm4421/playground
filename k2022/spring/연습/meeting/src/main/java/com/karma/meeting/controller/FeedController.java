package com.karma.meeting.controller;

import com.karma.meeting.model.dto.FeedDto;
import com.karma.meeting.model.util.CustomPrincipal;
import com.karma.meeting.service.FeedService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@Transactional
@RequiredArgsConstructor
@RequestMapping("/feed")
public class FeedController {
    private final FeedService feedService;

    /**
     * 피드 읽기
     * feedPage : 피드 페이지 읽기
     * feedDetail : 피드 1개 읽기
     */
    @GetMapping
    @Transactional(readOnly = true)
    public String FeedPageView(
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
            ModelMap modelMap
    ){
        Page<FeedDto> feeds = feedService.getFeedPage(pageable);
        modelMap.addAttribute("feeds", feeds);
        return "/feed/index";
    }

    @GetMapping("/{feedId}")
    @Transactional(readOnly = true)
    public String FeedView(
            @PathVariable Long feedId,
            ModelMap modelMap
    ){
        FeedDto feedDto = feedService.getFeed(feedId);
        modelMap.addAttribute("feed", feedDto);
        return "/feed/detail/index";
    }

    /**
     * 피드 추가
     * prefix : add
     * addFeedPage : 피드 쓰기 페이지
     * addFeed : 피드 쓰기 요청처리
     */
    @GetMapping("/add")
    public String addFeedView(){
        return "/feed/add/index";
    }

    @PostMapping("/add")
    public String addFeed(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        feedService.addFeed(title, content, principal.getUsername());
        return "redirect:/feed";
    }

    /**
     * 피드 수정
     * prefix : modify
     */

    @GetMapping("/modify/{feedId}")
    public String modifyFeedView(
            @PathVariable Long feedId,
            ModelMap modelMap
    ){
        FeedDto dto = feedService.getFeed(feedId);
        modelMap.addAttribute("feedId", feedId);
        modelMap.addAttribute("title", dto.getTitle());
        return "/feed/modify/index";
    }

    @PostMapping("/modify/{feedId}")
    public String modifyFeed(
            @PathVariable Long feedId,
            @RequestParam("title") String title,
            @RequestParam("content") String content
    ){
        feedService.modifyFeed(feedId, title, content);
        return "redirect:/feed";
    }

    /**
     * 피드 삭제
     * prefix : delete
     */
    @PostMapping("/delete/{feedId}")
    public String deleteFeed(
            @PathVariable Long feedId
    ){
        feedService.deleteFeed(feedId);
        return "redirect:/feed";
    }
}
