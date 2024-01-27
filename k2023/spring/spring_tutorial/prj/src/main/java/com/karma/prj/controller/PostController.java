package com.karma.prj.controller;

import com.karma.prj.controller.request.*;
import com.karma.prj.controller.response.EmotionResponse;
import com.karma.prj.controller.response.GetPostResponse;
import com.karma.prj.model.dto.CommentDto;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.model.util.CustomResponse;
import com.karma.prj.model.util.SearchType;
import com.karma.prj.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1")
public class PostController {
    private final PostService postService;

    // 포스팅 단건조회
    @GetMapping("/post/detail")
    public CustomResponse<GetPostResponse> getPost(@RequestParam("pid") Long postId){
        return CustomResponse.success(GetPostResponse.from(postService.getPost(postId)));
    }

    /**
     * 검색기능
     * @param searchType : 검색타입 - none, title, hashtag, content, user
     * @param searchValue : 검색어
     * @param pageable
     */
    @GetMapping("/post")
    public CustomResponse<Page<GetPostResponse>> getPostBySearch(
            @RequestParam("searchType") SearchType searchType,
            @RequestParam("searchValue") String searchValue,
            @PageableDefault(size = 20, sort = "createdAt",direction = Sort.Direction.DESC) Pageable pageable
    ){
        return CustomResponse.success(postService.getPostBySearch(pageable, searchType, searchValue).map(GetPostResponse::from));
    }

    /**
     * 내가 작성한 검색기능
     */
    @GetMapping("/post/my")
    public CustomResponse<Page<GetPostResponse>> getMyPosts(
            @PageableDefault(size = 20, sort = "createdAt",direction = Sort.Direction.DESC) Pageable pageable,
            Authentication authentication
    ){
        return CustomResponse.success(
                postService.getMyPosts(pageable, (UserEntity) authentication.getPrincipal())
                        .map(GetPostResponse::from)
        );
    }

    // 포스팅 작성
    @PostMapping("/post")
    public CustomResponse<Long> createPost(@RequestBody CreatePostRequest req, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return CustomResponse.success(postService.createPost(req.getTitle(), req.getContent(), user, req.getHashtags()));
    }

    // 포스팅 수정
    @PutMapping("/post")
    public CustomResponse<Void> modifyPost(
            @RequestBody ModifyPostRequest req,
            Authentication authentication
    ){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        postService.modifyPost(req.getPostId(), req.getTitle(), req.getContent(), user, req.getHashtags());
        return CustomResponse.success();
    }

    // 포스팅 삭제
    @DeleteMapping("/post")
    public CustomResponse<Void> deletePost(@RequestParam("pid") Long postId, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        postService.deletePost(postId, user.getId());
        return CustomResponse.success();
    }

    // 댓글 조회
    @GetMapping("/comment")
    public CustomResponse<Page<CommentDto>> getComment(
            @RequestParam("pid") Long postId,
            @PageableDefault(size = 10, sort = "createdAt",direction = Sort.Direction.DESC) Pageable pageable
    ){
        return CustomResponse.success(postService.getComments(postId, pageable));
    }

    // 댓글 작성
    @PostMapping("/comment")
    public CustomResponse<Void> createComment(@RequestBody CreateCommentRequest req, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        postService.createComment(req.getPostId(), req.getContent(), user);
        return CustomResponse.success();
    }

    // 댓글 수정
    @PutMapping("/comment")
    public CustomResponse<CommentDto> modifyPost(@RequestBody ModifyCommentRequest req, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return CustomResponse.success(postService.modifyComment(req.getPostId(), req.getCommentId(), req.getContent(), user));
    }

    // 댓글 삭제
    @DeleteMapping("/comment")
    public CustomResponse<Void> deletePost(@RequestBody DeleteCommentRequest req, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        postService.deleteComment(req.getPostId(), req.getCommentId(), user);
        return CustomResponse.success();
    }

    // 좋아요 & 싫어요 개수 가져오기 & 유저가 해당 포스팅을 좋아하는지 여부
    @GetMapping("/emotion")
    public CustomResponse<EmotionResponse> getEmotionInfo(@RequestParam("pid") Long postId, Authentication authentication){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return CustomResponse.success(EmotionResponse.from(postService.getEmotionInfo(user, postId)));
    }

    // 좋아요 & 싫어요 요청
    @PostMapping("/emotion")
    public CustomResponse<Void> handleEmotion(
            @RequestParam("pid") Long postId,
            @RequestBody EmotionRequest req,
            Authentication authentication
    ){
        UserEntity user = (UserEntity) authentication.getPrincipal();
        postService.handleEmotion(user, postId, req.getEmotionType(), req.getEmotionActionType());
        return CustomResponse.success();
    }
}
