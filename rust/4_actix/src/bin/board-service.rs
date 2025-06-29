use actix_web::{App, HttpServer, web};
use std::io;
use std::sync::Mutex;

#[path = "../handlers.rs"]
mod handlers;

#[path = "../routes.rs"]
mod routes;

#[path = "../state.rs"]
mod state;

#[path = "../models.rs"]
mod models;

use routes::*;
use state::AppState;

#[actix_rt::main]
async fn main() -> io::Result<()> {
    // 초기 상태값
    let shared_data = web::Data::new(AppState {
        health_check_resonse: "OK".to_string(),
        visit_count: Mutex::new(0),
        articles: Mutex::new(vec![]),
    });

    let app = move || {
        App::new()
            .app_data(shared_data.clone())
            .configure(general_routes)
            .configure(article_routes)
    };

    HttpServer::new(app).bind("127.0.0.1:3000")?.run().await
}
