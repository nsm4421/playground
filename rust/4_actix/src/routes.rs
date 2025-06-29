use super::handlers::*;
use actix_web::web;

pub fn general_routes(config: &mut web::ServiceConfig) {
    config.route("/health", web::get().to(health_check_handler));
}

pub fn article_routes(config: &mut web::ServiceConfig) {
    // create argicle
    config
        // set url prefix
        .service(web::scope("/article"))
        .route("/{author}", web::get().to(find_articles_by_author))
        .route("/", web::post().to(create_article));
}
