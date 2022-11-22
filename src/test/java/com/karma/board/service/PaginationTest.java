package com.karma.board.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.*;

@DisplayName("Pagination")
@SpringBootTest
class PaginationTest {

    private final ArticleService articleService;

    public PaginationTest(@Autowired ArticleService articleService) {
        this.articleService = articleService;
    }

    @DisplayName("현재 페이지 번호 전달 > 페이징 바 반환")
    @MethodSource
    @ParameterizedTest(name = "[{index}]th | Input : {0} {1} | Ouput : {2}")
    @Test
    void givenCurrentPageNumber_WhenCalc_ThenReturnPagingBar(
            Integer currentPage, Integer totalPage, List<Integer> expected
    ) {
        List<Integer> actual = articleService.getPaginationBarNumbers(currentPage, totalPage);
        assertThat(actual).isEqualTo(expected);
    }

    static Stream<Arguments> givenCurrentPageNumber_WhenCalc_ThenReturnPagingBar(){
        return Stream.of(
                Arguments.arguments(0, 6, List.of(0,1,2,3,4)),
                Arguments.arguments(1, 6, List.of(0,1,2,3,4)),
                Arguments.arguments(2, 6, List.of(0,1,2,3,4)),
                Arguments.arguments(3, 6, List.of(1,2,3,4,5)),
                Arguments.arguments(4, 6, List.of(2,3,4,5)),
                Arguments.arguments(5, 6, List.of(3,4,5))
        );
    }
}