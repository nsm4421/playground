package com.karma.karmaboard.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


import java.util.List;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
class PaginationServiceTest {

    private final PaginationService sut;

    public PaginationServiceTest(@Autowired PaginationService paginationService) {
        this.sut = paginationService;
    }

    @DisplayName("Input:CurrentPage,TotalPages->Output:PagingBarList")
    @MethodSource
    @ParameterizedTest(name = "[{index}] currentPage : {0} / totalPage : {1} -> pageBar : {2}")
    void paginationTest(int currentPage, int totalPages, List<Integer> expectedResult){
        List<Integer> actualResult = sut.getPagination(currentPage, totalPages);
        assertThat(actualResult).isEqualTo(expectedResult);
    }

    static Stream<Arguments> paginationTest(){
        return Stream.of(
                Arguments.arguments(0,13, List.of(0,1,2,3,4)),
                Arguments.arguments(1,13, List.of(0,1,2,3,4)),
                Arguments.arguments(2,13, List.of(0,1,2,3,4)),
                Arguments.arguments(12,13, List.of(10,11,12))
        );
    }
}