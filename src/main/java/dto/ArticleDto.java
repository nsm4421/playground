package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public record ArticleDto (String title,String content,String hashtag,LocalDateTime createdAt,String createdBy) {
    public static ArticleDto of(String title, String content, String hashtag, LocalDateTime createdAt, String createdBy) {
        return new ArticleDto(title,content, hashtag, createdAt, createdBy);
    }
}
