package com.karma.compass.util;


import com.karma.compass.domain.dto.DocumentDto;

public class HaversineFormula {
    /**
     * Notation
     * r : 지구의 반지름
     * lat1, lat2 : 두 점의 위도
     * long1, long2 : 두 점의 경도
     */
    private static final Double r = 6371.;  // 지구의 반지름은 약 6371km

    public Double getDistance(Double lat1, Double lat2, Double long1, Double long2){
        return 2*r*Math.acos(Math.sqrt(Math.pow(Math.sin((lat1-lat2)/2), 2) + Math.cos(lat1)*Math.cos(lat2)*Math.pow(Math.sin((long1-long2)/2), 2)));
    }
}
