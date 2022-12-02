package com.karma.meeting.model.dto;

import com.karma.meeting.model.entity.Feed;

import java.util.Set;
import java.util.stream.Collectors;

public class FeedDto {
    private String title;
    private String content;
    private UserAccountDto userAccountDto;
    private Set<CommentDto> commentDtos;

    private FeedDto(String title, String content, UserAccountDto userAccountDto, Set<CommentDto> commentDtos) {
        this.title = title;
        this.content = content;
        this.userAccountDto = userAccountDto;
        this.commentDtos = commentDtos;
    }

    protected FeedDto(){}

    public static FeedDto of(String title, String content, UserAccountDto userAccountDto, Set<CommentDto> commentDtos){
        return new FeedDto(title, content, userAccountDto, commentDtos);
    }

    public static FeedDto from(Feed feed){
        return FeedDto.of(
                feed.getTitle(),
                feed.getContent(),
                UserAccountDto.from(feed.getUserAccount()),
                feed.getComments().stream().map(CommentDto::from).collect(Collectors.toSet())
        );
    }
}
