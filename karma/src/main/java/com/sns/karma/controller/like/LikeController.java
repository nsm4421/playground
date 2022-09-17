package com.sns.karma.controller.like;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.controller.post.request.ModifyPostRequest;
import com.sns.karma.controller.post.request.WritePostRequest;
import com.sns.karma.controller.post.response.GetPostResponse;
import com.sns.karma.controller.post.response.ModifyPostResponse;
import com.sns.karma.controller.post.response.WritePostResponse;
import com.sns.karma.model.post.Post;
import com.sns.karma.service.LikeService;
import com.sns.karma.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post/like")
public class LikeController {

    private final LikeService likeService;

    // 좋아요 개수
    @GetMapping("/{postId}")
    public CustomResponse<Long> getLikeNum(@PathVariable Long postId){
        return CustomResponse.success(likeService.getLikeNum(postId));
    }

    // 좋아요
    @PostMapping("/{postId}")
    public CustomResponse<Void> likePost(@PathVariable Long postId, Authentication authentication){
        likeService.addLike(postId, authentication.getName());
        return CustomResponse.success();
    }
}