package com.karma.karmaboard.service;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.IntStream;

@Service
public class PaginationService {

    private static final int BAR_LENGTH = 10;

    public List<Integer> getPagination(int currentPage, int totalPages){
        int firstPage = Math.max(currentPage - (BAR_LENGTH/2), 0);
        int lastPage =  Math.min(currentPage + (BAR_LENGTH/2), totalPages);
        return IntStream.range(firstPage, lastPage).boxed().toList();
    }

    public int getBarLength(){
        return BAR_LENGTH;
    }
}
