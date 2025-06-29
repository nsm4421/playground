use super::models::Article;
use std::sync::Mutex;

pub struct AppState {
    pub health_check_resonse: String,
    // multi thread를 사용할 것이므로, 각 thread의 제어권을 통제하기 위한 변수가 필요함
    pub visit_count: Mutex<u32>,
    pub articles : Mutex<Vec<Article>>,
}
