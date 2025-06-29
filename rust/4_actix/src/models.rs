use actix_web::web;
use chrono::NaiveDateTime;
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Debug, Clone)]
pub struct Article {
    pub author : i32,
    pub article_id : Option<i32>,
    pub title : String,
    pub created_at : Option<NaiveDateTime>
}

impl From<web::Json<Article>> for Article {
    fn from(json: web::Json<Article>) -> Self {
        Article {
            author: json.author,
            article_id: json.article_id,
            title: json.title.clone(),
            created_at: json.created_at,
        }
    }
}