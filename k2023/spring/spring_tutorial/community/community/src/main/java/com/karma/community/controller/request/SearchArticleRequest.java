package com.karma.community.controller.request;

import com.karma.community.model.util.SearchType;
import lombok.Data;

@Data
public class SearchArticleRequest {
    private SearchType searchType;
    private String searchWord;
}
