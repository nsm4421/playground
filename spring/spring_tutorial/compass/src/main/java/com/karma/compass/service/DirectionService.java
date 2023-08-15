package com.karma.compass.service;

import com.karma.compass.domain.dto.DirectionDto;
import com.karma.compass.domain.dto.DocumentDto;
import com.karma.compass.util.HaversineFormula;
import com.karma.compass.util.KakaoApiService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DirectionService {
    private final StoreService storeService;
    private final KakaoApiService kakaoApiService;
    private final HaversineFormula hf;
    private static final Integer MAX_SEARCH_COUNT = 5;
    private static final Integer MAX_DISTANCE = 5;

    public List<DirectionDto> getDirectionDtoList(DocumentDto document){
        /**
         * 현재 위치(document)가 주어지는 경우 5km 이내에서 가장 가까운 가게 5곳 이내로 찾아줌 
         */
        if (Objects.isNull(document)){return Collections.emptyList();}
        return storeService
                // 모든 가게 list 가져오기
                .getDtoList()
                .stream()
                // 각 가게(store)와 현재 위치(document)를 가지고 direction 객체 만들기
                .map(store -> DirectionDto.of(
                        document.getAddressName(),
                        document.getLatitude(),
                        document.getLongitude(),
                        store.getAddress(),
                        store.getName(),
                        store.getLatitude(),
                        store.getLongitude(),
                        // 하버 사인 공식으로 거리계산
                        hf.getDistance(
                                document.getLatitude(),
                                store.getLatitude(),
                                document.getLongitude(),
                                store.getLongitude())))
                // 5km 이내의 가게만
                .filter(direction->direction.getDistance()<=MAX_DISTANCE)
                // 거리순으로 오름차순
                .sorted(Comparator.comparing(DirectionDto::getDistance))
                // 최대 5개의 가게만
                .limit(MAX_SEARCH_COUNT)
                .collect(Collectors.toList());
    }
}
