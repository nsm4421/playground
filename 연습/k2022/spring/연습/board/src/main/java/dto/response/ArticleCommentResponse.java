package dto.response;

import dto.ArticleCommentDto;

import java.time.LocalDateTime;

public record ArticleCommentResponse(
        Long id,
        String comment,
        LocalDateTime createdAt,
        String email,
        String nickname,
        String userId
) {

    public static ArticleCommentResponse of(Long id, String comment, LocalDateTime createdAt, String email, String nickname, String userId) {
        return new ArticleCommentResponse(id, comment, createdAt, email, nickname, userId);
    }

    public static ArticleCommentResponse from(ArticleCommentDto dto) {
        String nickname = dto.userAccountDto().nickname();
        if (nickname == null || nickname.isBlank()) {
            nickname = dto.userAccountDto().userId();
        }

        return new ArticleCommentResponse(
                dto.id(),
                dto.content(),
                dto.createdAt(),
                dto.userAccountDto().email(),
                nickname,
                dto.userAccountDto().userId()
        );
    }

}