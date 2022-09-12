package com.sns.karma.controller.post;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.model.post.Post;
import com.sns.karma.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
public class PostController {

    private final PostService postService;

    // 게시글 작성
    @PostMapping("/write")
    public CustomResponse<WritePostResponse> writePost(@RequestBody WritePostRequest writePostRequest,
                                                       Authentication authentication){
        // 요청 parsing
        String title = writePostRequest.getTitle();
        String body = writePostRequest.getBody();
        String author = authentication.getName();

        // 게시글 작성
        Post post = postService.writePost(title, body, author);

        // 응답 반환
        return CustomResponse.success(WritePostResponse.fromPost(post));
    }

    // 게시글 수정
    @PutMapping("/{postId}")
    public CustomResponse<ModifyPostResponse> modifyPost(@PathVariable Long postId,
                           @RequestBody ModifyPostRequest modifyPostRequest,
                           Authentication authentication){
        // 요청 parsing
        String title = modifyPostRequest.getTitle();
        String body = modifyPostRequest.getBody();
        String author = authentication.getName();

        // 게시글 수정
        Post post = postService.modifyPost(title, body, author, postId);

        // 응답 반환
        return CustomResponse.success(ModifyPostResponse.fromPost(post));
    }

    // 게시글 삭제
    @DeleteMapping("/{postId}")
    public CustomResponse<Void> deletePost(@PathVariable Long postId,
                                           Authentication authentication){
        String author = authentication.getName();
        postService.deletePost(author, postId);
        return CustomResponse.success();
    }

    // 전체 게시글 목록
    @GetMapping
    public CustomResponse<Page<GetPostResponse>> getAllPost(Pageable pageable){
        return CustomResponse.success(
                postService.getAllPost(pageable)
                        .map(GetPostResponse::fromPost));
    }

    // 내가 쓴 게시글 목록
    @GetMapping
    public CustomResponse<Page<GetPostResponse>> getMyPost(Pageable pageable, Authentication authentication){
        return CustomResponse.success(
                postService.getMyPost(pageable, authentication.getName())
                        .map(GetPostResponse::fromPost));
    }

}
