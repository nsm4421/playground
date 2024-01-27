package com.karma.board.repository;

import com.karma.board.domain.Article;
import com.karma.board.domain.QArticle;
import com.querydsl.core.types.dsl.DateTimeExpression;
import com.querydsl.core.types.dsl.StringExpression;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ArticleRepository extends
        JpaRepository<Article, Long>,
        QuerydslPredicateExecutor<Article>,
        QuerydslBinderCustomizer<QArticle>
{
    Page<Article> findByTitleContaining(String title, Pageable pageable);
    Page<Article> findByUserAccount_UsernameContaining(String username, Pageable pageable);
    Page<Article> findByContentContaining(String content, Pageable pageable);
    Page<Article> findByHashtags(String hashtags, Pageable pageable);

    @Override
    default void customize(QuerydslBindings bindings, QArticle root){
        // 검색기능을 부여할 필드 설정
        bindings.excludeUnlistedProperties(true);
        bindings.including(root.title, root.hashtags, root.createdAt, root.createdBy);
        // 검색 옵션
        // 제목 - 대소문자 무시, 부분검색
        bindings.bind(root.title).first(StringExpression::containsIgnoreCase);
        // 해쉬태그 - 대소문자 무시, 부분검색
        bindings.bind(root.hashtags).first(StringExpression::containsIgnoreCase);
        // 생성일시 - Exact match
        bindings.bind(root.createdAt).first(DateTimeExpression::eq);
        // 작성자 - 대소문자 무시, 부분검색
        bindings.bind(root.createdBy).first(StringExpression::containsIgnoreCase);
    }
}
