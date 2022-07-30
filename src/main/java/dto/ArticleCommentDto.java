package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public record ArticleCommentDto (String comment, String createdBy, String modifiedBy, LocalDateTime createdAt, LocalDateTime modifiedAt) {
    public static ArticleCommentDto of(String comment, String createdBy, String modifiedBy, LocalDateTime createdAt, LocalDateTime modifiedAt) {
        return new ArticleCommentDto(comment, createdBy, modifiedBy, createdAt, modifiedAt);
    }
}
