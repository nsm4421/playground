package com.sns.karma.controller.post.request;

import com.sns.karma.model.post.SearchType;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class GetSearchedPostRequest {
    String keyword;
    SearchType searchType;
}
