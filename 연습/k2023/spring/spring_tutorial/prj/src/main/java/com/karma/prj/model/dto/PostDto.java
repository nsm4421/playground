package com.karma.prj.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
public class PostDto {
    private Long id;
    private String title;
    private String content;
    private String nickname;
    private Set<String> hashtags;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private String createdBy;
    private String modifiedBy;

    private PostDto(
            Long id,
            String title,
            String content,
            String nickname,
            Set<String> hashtags,
            LocalDateTime createdAt,
            LocalDateTime modifiedAt,
            String createdBy,
            String modifiedBy
    ) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.nickname = nickname;
        this.hashtags = hashtags;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }

    protected PostDto(){}

    public static PostDto of(Long id, String title, String content, String nickname, Set<String> hashtags, LocalDateTime createdAt, LocalDateTime modifiedAt, String createdBy, String modifiedBy) {
        return new PostDto(id, title, content, nickname, hashtags, createdAt, modifiedAt, createdBy, modifiedBy);
    }
}