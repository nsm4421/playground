package com.karma.prj.controller.response;

import com.karma.prj.model.dto.PostDto;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
public class GetPostResponse {
    private Long id;
    private String title;
    private String content;
    private String nickname;
    private Set<String> hashtags;
    private LocalDateTime createdAt;

    private GetPostResponse(Long id, String title, String content, String nickname, Set<String> hashtags, LocalDateTime createdAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.nickname = nickname;
        this.hashtags = hashtags;
        this.createdAt = createdAt;
    }

    protected GetPostResponse(){}

    public static GetPostResponse of(Long id, String title, String content, String nickname, Set<String> hashtags, LocalDateTime createdAt) {
       return new GetPostResponse(id,title,content,nickname,hashtags,createdAt);
    }

    public static GetPostResponse from(PostDto dto){
        return GetPostResponse.of(
                dto.getId(),
                dto.getTitle(),
                dto.getContent(),
                dto.getNickname(),
                dto.getHashtags(),
                dto.getCreatedAt()
        );
    }
}
