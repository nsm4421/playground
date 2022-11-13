package com.karma.board.repository;

import com.karma.board.domain.Article;
import com.karma.board.domain.Comment;
import com.karma.board.domain.QArticle;
import com.karma.board.domain.QComment;
import com.querydsl.core.types.dsl.DateTimeExpression;
import com.querydsl.core.types.dsl.StringExpression;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface CommentRepository extends
        JpaRepository<Comment, Long>,
        QuerydslPredicateExecutor<Comment>,
        QuerydslBinderCustomizer<QComment>
{
    @Override
    default void customize(QuerydslBindings bindings, QComment root){
        // 검색기능을 부여할 필드 설정
        bindings.excludeUnlistedProperties(true);
        bindings.including(root.content, root.createdBy);
        // 검색 옵션
        // 댓글, 작성자 - 대소문자 무시, 부분검색
        bindings.bind(root.content).first(StringExpression::containsIgnoreCase);
        bindings.bind(root.createdBy).first(StringExpression::containsIgnoreCase);
    }
}
