package com.karma.chat.controller


import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.feed.CreateFeedRequestDto
import com.karma.chat.controller.dto.feed.ModifyFeedRequestDto
import com.karma.chat.domain.feed.Feed
import com.karma.chat.service.FeedService
import com.karma.chat.util.UserAuthorize
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault

import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.User
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/feed")
@UserAuthorize
class FeedController(
    private val feedService: FeedService
) {

    @GetMapping
    fun fetchFeeds(
        @PageableDefault pageable: Pageable
    ): ResponseEntity<BodyDto<Iterable<Feed>>> {
        try {
            val feeds = feedService.fetchFeeds(pageable)
            return ResponseEntity.ok(BodyDto(message = "success", data = feeds))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "fetch feed fail"))
        }
    }

    @PostMapping
    fun createFeed(
        @RequestBody req: CreateFeedRequestDto
    ): ResponseEntity<BodyDto<Long>> {
        try {
            val feedId = feedService.createFeed(content = req.content, media = req.media)
            return ResponseEntity.ok(BodyDto(message = "success", data = feedId))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "create feed fail"))
        }
    }

    @PutMapping
    fun modifyFeed(
        @RequestBody req: ModifyFeedRequestDto,
        @AuthenticationPrincipal user: User
    ): ResponseEntity<BodyDto<Long>> {
        try {
            val feedId = feedService.modifyFeed(
                feedId = req.feedId,
                content = req.content,
                media = req.media,
                username = user.username
            )
            return ResponseEntity.ok(BodyDto(message = "success", data = feedId))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "delete feed fail"))
        }
    }

    @DeleteMapping("/{feedId}")
    fun deleteFeed(
        @PathVariable feedId: Long,
        @AuthenticationPrincipal user: User
    ): ResponseEntity<BodyDto<Long>> {
        try {
            feedService.deleteFeed(feedId = feedId, username = user.username)
            return ResponseEntity.ok(BodyDto(message = "success", data = feedId))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "delete feed fail"))
        }
    }
}