package com.karma.karmaboard.repository.querydsl;

import com.karma.karmaboard.domain.Article;
import com.karma.karmaboard.domain.QArticle;
import com.querydsl.jpa.JPQLQuery;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import java.util.List;

public class ArticleRepositoryCustomImpl
        extends QuerydslRepositorySupport
        implements ArticleRepositoryCustom{

    public ArticleRepositoryCustomImpl(){
        super(Article.class);
    }

    public List<String> findAllDistinctHashtag() {
        QArticle article = QArticle.article;
        JPQLQuery<String> query = from(article)
                .distinct()
                .select(article.hashtag)
                .where(article.hashtag.isNotNull());
        return query.fetch();
    }
}
