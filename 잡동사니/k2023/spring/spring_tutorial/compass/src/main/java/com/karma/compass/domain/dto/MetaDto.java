package com.karma.compass.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MetaDto {
    /**
     * total_count(Integer)	검색어에 검색된 문서 수
     * pageable_count(Integer)	total_count 중 노출 가능 문서 수(최대: 45)
     * is_end(Boolean)	현재 페이지가 마지막 페이지인지 여부, 값이 false면 다음 요청 시 page 값을 증가시켜 다음 페이지 요청 가능
     */
    @JsonProperty("total_count")
    private Integer totalCount;
}
