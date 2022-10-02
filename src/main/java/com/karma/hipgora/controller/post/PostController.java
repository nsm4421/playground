package com.karma.hipgora.controller.post;

import com.karma.hipgora.controller.MyResponse;
import com.karma.hipgora.controller.requests.ModifyPostRequest;
import com.karma.hipgora.controller.requests.WritePostRequest;
import com.karma.hipgora.controller.responses.GetPostResponse;
import com.karma.hipgora.model.post.Post;
import com.karma.hipgora.service.post.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
public class PostController {

    private final PostService postService;

    @GetMapping
    public MyResponse<Page<GetPostResponse>> getAllPost(Pageable pageable){
        Page<Post> posts = postService.getAllPost(pageable);
        Page<GetPostResponse> getAllPostResponses = posts.map(GetPostResponse::from);
        return MyResponse.success(getAllPostResponses);
    }

    @GetMapping("/my-post")
    public MyResponse<Page<GetPostResponse>> getMyPost(Pageable pageable, Authentication authentication) {
        String username = authentication.getName();
        Page<Post> posts = postService.getAllMyPost(pageable, username);
        Page<GetPostResponse> getAllPostResponses = posts.map(GetPostResponse::from);
        return MyResponse.success(getAllPostResponses);
    }

    @PostMapping
    public MyResponse<Void> writePost(@RequestBody WritePostRequest writePostRequest,
                                      Authentication authentication){
        String title = writePostRequest.getTitle();
        String body = writePostRequest.getBody();
        Set<String> hashtags = writePostRequest.getHashtags();
        String username = authentication.getName();
        postService.writePost(title, body, hashtags, username);
        return MyResponse.success();
    }

    @PutMapping("/{postId}")
    public MyResponse<Void> modifyPost(@RequestBody ModifyPostRequest modifyPostRequest,
                                       @PathVariable Long postId,
                                       Authentication authentication){
        String title = modifyPostRequest.getTitle();
        String body = modifyPostRequest.getBody();
        Set<String> hashtags = modifyPostRequest.getHashtags();
        String username = authentication.getName();
        postService.modifyPost(postId, title, body, hashtags, username);
        return MyResponse.success();
    }

    @DeleteMapping("/{postId}")
    public MyResponse<Void> deletePost(@PathVariable Long postId, Authentication authentication){
        String username = authentication.getName();
        postService.deletePost(postId, username);
        return MyResponse.success();
    }
}
