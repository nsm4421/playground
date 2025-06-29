use super::models::Article;
use super::state::AppState;
use actix_web::{HttpResponse, web};
use chrono::Utc;

pub async fn health_check_handler(app_state: web::Data<AppState>) -> HttpResponse {
    let health_check_response = &app_state.health_check_resonse;
    let mut visit_count = app_state.visit_count.lock().unwrap();
    let response = format!("{} {} times", health_check_response, visit_count);
    *visit_count += 1; // 각 쓰레드가 접근할 때 마다 visit_count증가
    HttpResponse::Ok().json(&response)
}

pub async fn create_article(
    new_article: web::Json<Article>,
    app_state: web::Data<AppState>,
) -> HttpResponse {
    print!("create article request");
    let count_for_user = app_state
        .articles
        .lock()
        .unwrap()
        .clone()
        .into_iter()
        .filter(|article| article.author == new_article.author)
        .count();

    let new_article = Article {
        author: new_article.author,
        title: new_article.title.clone(),
        article_id: Some((count_for_user + 1) as i32),
        created_at: Some(Utc::now().naive_utc()),
    };

    app_state.articles.lock().unwrap().push(new_article.clone());

    HttpResponse::Ok().json(format!(
        "article added successfully with id {}",
        new_article.article_id.unwrap()
    ))
}

pub async fn find_articles_by_author(
    params: web::Path<i32>,
    app_state: web::Data<AppState>,
) -> HttpResponse {
    let target_author = params.into_inner();
    let filtered_articles = app_state
        .articles
        .lock()
        .unwrap()
        .clone()
        .into_iter()
        .filter(|article| article.author == target_author)
        .collect::<Vec<Article>>();

    HttpResponse::Ok().json(filtered_articles)
}

#[cfg(test)]
mod tests {
    use super::*;
    use actix_web::http::StatusCode;
    use std::sync::Mutex;

    #[actix_rt::test]
    async fn create_article_test() {
        let new_article = web::Json(Article {
            article_id: None,
            title: "create article test".into(),
            author: 1,
            created_at: None,
        });
        let app_state: web::Data<AppState> = web::Data::new(AppState {
            health_check_resonse: "".to_string(),
            visit_count: Mutex::new(0),
            articles: Mutex::new(vec![]),
        });
        let response = create_article(new_article, app_state).await;
        assert_eq!(response.status(), StatusCode::OK);
    }

    #[actix_rt::test]
    async fn find_articles_by_author_test() {
        let app_state: web::Data<AppState> = web::Data::new(AppState {
            health_check_resonse: "".to_string(),
            visit_count: Mutex::new(0),
            articles: Mutex::new(vec![]),
        });
        let author: web::Path<i32> = web::Path::from(1);
        let response = find_articles_by_author(author, app_state).await;
        assert_eq!(response.status(), StatusCode::OK);
    }
}
