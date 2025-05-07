package com.karma.compass.domain.dto;


import com.karma.compass.domain.entity.StoreEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreDto {
    private String name;
    private String address;
    private Double latitude;
    private Double longitude;

    private StoreDto(String name, String address, Double latitude, Double longitude) {
        this.name = name;
        this.address = address;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    protected StoreDto() {
    }

    public static StoreDto of(String name, String address, Double latitude, Double longitude) {
        return new StoreDto(name, address, latitude, longitude);
    }

    public static StoreDto from(StoreEntity entity){
        return StoreDto.of(
                entity.getName(),
                entity.getAddress(),
                entity.getLatitude(),
                entity.getLongitude()
        );
    }
}
