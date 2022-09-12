package com.sns.karma.controller.post;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
public class PostController {

    private final PostService postService;

    @PostMapping("/write")
    public CustomResponse<Void> writePost(@RequestBody WritePostRequest writePostRequest, Authentication authentication){
        String title = writePostRequest.getTitle();
        String body = writePostRequest.getBody();
        String author = authentication.getName();
        postService.writePost(title, body, author);
        return CustomResponse.success();
    }
}
