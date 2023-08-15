package com.karma.compass.domain.dto;

import com.karma.compass.domain.entity.DirectionEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DirectionDto {
    private String inputAddress;
    private Double inputLatitude;
    private Double inputLongitude;
    private String targetAddress;
    private String targetStore;
    private Double targetLatitude;
    private Double targetLongitude;
    private Double distance;

    private DirectionDto(String inputAddress, Double inputLatitude, Double inputLongitude, String targetAddress, String targetStore, Double targetLatitude, Double targetLongitude, Double distance) {
        this.inputAddress = inputAddress;
        this.inputLatitude = inputLatitude;
        this.inputLongitude = inputLongitude;
        this.targetAddress = targetAddress;
        this.targetStore = targetStore;
        this.targetLatitude = targetLatitude;
        this.targetLongitude = targetLongitude;
        this.distance = distance;
    }

    protected DirectionDto(){}

    public static DirectionDto of(String inputAddress, Double inputLatitude, Double inputLongitude, String targetAddress, String targetStore, Double targetLatitude, Double targetLongitude, Double distance) {
        return new DirectionDto(inputAddress, inputLatitude, inputLongitude, targetAddress, targetStore, targetLatitude, targetLongitude, distance);
    }

    public static DirectionDto from(DirectionEntity entity){
        return DirectionDto.of(
                entity.getInputAddress(),
                entity.getInputLatitude(),
                entity.getInputLongitude(),
                entity.getTargetAddress(),
                entity.getTargetStore(),
                entity.getTargetLatitude(),
                entity.getTargetLongitude(),
                entity.getDistance()
        );
    }
}
