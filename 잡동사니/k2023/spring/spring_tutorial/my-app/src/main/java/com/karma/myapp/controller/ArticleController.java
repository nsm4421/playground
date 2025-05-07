package com.karma.myapp.controller;

import com.karma.myapp.controller.request.ModifyArticleRequest;
import com.karma.myapp.controller.request.WriteArticleRequest;
import com.karma.myapp.controller.response.CustomResponse;
import com.karma.myapp.controller.response.GetArticleResponse;
import com.karma.myapp.domain.constant.SearchType;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.service.ArticleService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/article")
public class ArticleController {
    private final ArticleService articleService;

    /**
     * 게시글 단건 조회
     *
     * @param articleId 조회할 게시글 id
     * @return
     */
    @GetMapping("/{articleId}")
    public CustomResponse<GetArticleResponse> getArticle(@PathVariable Long articleId) {
        return CustomResponse.success(GetArticleResponse.from(articleService.getArticle(articleId)));
    }

    /**
     * 게시글 다건 조회
     *
     * @param sortField     정렬조건 (created_at 外 컬럼명)
     * @param sortDirection 정렬방향 (ASC,DESC)
     * @param page          페이지수
     * @param size          조회건수
     * @param searchType    검색유형
     * @param searchText    검색어
     * @return page of GetArticleResponse
     */
    @GetMapping
    public CustomResponse<Page<GetArticleResponse>> getArticles(
            @RequestParam(value = "sort-field", required = false) String sortField,
            @RequestParam(value = "sort-direction", required = false) SortDirection sortDirection,
            @RequestParam(value = "page", required = false, defaultValue = "0") int page,
            @RequestParam(value = "size", required = false, defaultValue = "20") int size,
            @RequestParam(value = "search-type", required = false) SearchType searchType,
            @RequestParam(value = "search-text", required = false) String searchText
    ) {
        Pageable pageable = PageRequest.of(page, size, getSortDirection(sortField, sortDirection));
        return CustomResponse.success(
                articleService.getArticles(searchType, searchText, pageable).map(GetArticleResponse::from),
                "get articles success"
        );
    }

    /**
     * 게시글 작성
     *
     * @param req       제목 / 본문 / 해시태그
     * @param principal 로그인 유저의 인증정보
     * @return 작성한 게시글
     */
    @PostMapping
    public CustomResponse<GetArticleResponse> writeArticle(
            @RequestBody WriteArticleRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(
                GetArticleResponse.from(
                        articleService.writeArticle(principal, req.getTitle(), req.getContent(), req.getHashtags())),
                "write article success"
        );
    }

    /**
     * 게시글 수정
     *
     * @param req       수정할 게시글 id / 제목 / 본문 / 해시태그
     * @param principal 로그인 유저의 인증정보
     * @return 수정한 게시글
     */
    @PutMapping
    public CustomResponse<GetArticleResponse> modifyArticle(
            @RequestBody ModifyArticleRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        return CustomResponse.success(
                GetArticleResponse.from(articleService.modifyArticle(principal, req.getArticleId(), req.getTitle(), req.getContent(), req.getHashtags())),
                "modify article success"
        );
    }

    /**
     * 게시글 삭제
     *
     * @param articleId 삭제할 게시글 id
     * @param principal 로그인한 유저의 인증정보
     * @return
     */
    @DeleteMapping("/{articleId}")
    public CustomResponse<Void> deleteArticle(
            @PathVariable Long articleId,
            @AuthenticationPrincipal CustomPrincipal principal
    ) {
        articleService.deleteArticle(principal, articleId);
        return CustomResponse.success(null, "delete article success");
    }

    private enum SortDirection {
        ASC, DESC;
    }

    private Sort getSortDirection(String sortField, SortDirection sortDirection){
        if (sortDirection == null || sortField == null){
            return Sort.by("createdAt").descending();
        }
        return switch (sortDirection){
            case ASC -> Sort.by(sortField).ascending().and(Sort.by("createdAt").descending());
            case DESC -> Sort.by(sortField).descending().and(Sort.by("createdAt").descending());
        };
    }
}
