package com.karma.compass.domain.entity;

import com.karma.compass.domain.util.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;

import javax.persistence.*;
import java.util.Objects;

@Entity(name="direction")
@Getter
@Setter
@SQLDelete(sql = "UPDATE direction SET removed_at = NOW() WHERE id=?")
public class DirectionEntity extends AuditingFields {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String inputAddress;
    private Double inputLatitude;
    private Double inputLongitude;
    private String targetAddress;
    private String targetStore;
    private Double targetLatitude;
    private Double targetLongitude;
    private Double distance;

    private DirectionEntity(String inputAddress, Double inputLatitude, Double inputLongitude, String targetAddress, String targetStore, Double targetLatitude, Double targetLongitude, Double distance) {
        this.inputAddress = inputAddress;
        this.inputLatitude = inputLatitude;
        this.inputLongitude = inputLongitude;
        this.targetAddress = targetAddress;
        this.targetStore = targetStore;
        this.targetLatitude = targetLatitude;
        this.targetLongitude = targetLongitude;
        this.distance = distance;
    }

    protected DirectionEntity(){}

    public static DirectionEntity of(String inputAddress, Double inputLatitude, Double inputLongitude, String targetAddress, String targetStore, Double targetLatitude, Double targetLongitude, Double distance) {
        return new DirectionEntity(inputAddress, inputLatitude, inputLongitude, targetAddress, targetStore, targetLatitude, targetLongitude, distance);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DirectionEntity that = (DirectionEntity) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
