package com.sns.karma.controller.post;

import com.sns.karma.controller.CustomResponse;
import com.sns.karma.controller.post.request.GetSearchedPostRequest;
import com.sns.karma.controller.post.request.ModifyPostRequest;
import com.sns.karma.controller.post.request.WritePostRequest;
import com.sns.karma.controller.post.response.GetPostResponse;
import com.sns.karma.controller.post.response.ModifyPostResponse;
import com.sns.karma.controller.post.response.WritePostResponse;
import com.sns.karma.model.post.Post;
import com.sns.karma.model.post.SearchType;
import com.sns.karma.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
public class PostController {

    private final PostService postService;

    // 게시글 작성
    @PostMapping
    public CustomResponse<WritePostResponse> writePost(@RequestBody WritePostRequest writePostRequest,
                                                       Authentication authentication) {
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
                                                         Authentication authentication) {
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
                                           Authentication authentication) {
        String author = authentication.getName();
        postService.deletePost(author, postId);
        return CustomResponse.success();
    }

    // 전체 게시글 목록
    @GetMapping
    public CustomResponse<Page<GetPostResponse>> getAllPost(
            @PageableDefault(size = 10, sort = "registeredAt", direction = Sort.Direction.DESC) Pageable pageable) {
        return CustomResponse.success(
                postService.getAllPost(pageable)
                        .map(GetPostResponse::fromPost));
    }

    @GetMapping("/search")
    public CustomResponse<Page<GetPostResponse>> getSearchedPost(
            @PageableDefault(size = 10, sort = "registeredAt", direction = Sort.Direction.DESC) Pageable pageable,
            @RequestBody GetSearchedPostRequest getSearchedPostRequest) {

        String keyword = getSearchedPostRequest.getKeyword();
        SearchType searchType = getSearchedPostRequest.getSearchType();
        return CustomResponse.success(
                postService.getSearchedPost(pageable, searchType, keyword)
                        .map(GetPostResponse::fromPost));
    }

    // 내가 쓴 게시글 목록
    @GetMapping("/my-post")
    public CustomResponse<Page<GetPostResponse>> getMyPost(Pageable pageable, Authentication authentication) {
        return CustomResponse.success(
                postService.getUsersPost(pageable, authentication.getName())
                        .map(GetPostResponse::fromPost));
    }
}