package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.Feed;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
public class FeedDto {

    private Long id;
    private String title;
    private String content;
    private UserAccountDto userAccountDto;
    private Set<CommentDto> commentDtos;
    private LocalDateTime createdAt;
    private String createdBy;

    private FeedDto(Long id, String title, String content, UserAccountDto userAccountDto, Set<CommentDto> commentDtos, LocalDateTime createdAt, String createdBy) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.userAccountDto = userAccountDto;
        this.commentDtos = commentDtos;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    protected FeedDto(){}

    public static FeedDto of(Long id, String title, String content, UserAccountDto userAccountDto, Set<CommentDto> commentDtos, LocalDateTime createdAt, String createdBy){
        return new FeedDto(id, title, content, userAccountDto, commentDtos, createdAt, createdBy);
    }

    public static FeedDto from(Feed feed){
        return FeedDto.of(
                feed.getId(),
                feed.getTitle(),
                feed.getContent(),
                UserAccountDto.from(feed.getUserAccount()),
                feed.getComments().stream().map(CommentDto::from).collect(Collectors.toSet()),
                feed.getCreatedAt(),
                feed.getCreatedBy()
        );
    }
}
