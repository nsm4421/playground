package com.karma.compass.domain.entity;

import com.karma.compass.domain.util.AuditingFields;
import lombok.*;
import org.hibernate.annotations.SQLDelete;

import javax.persistence.*;
import java.util.Objects;

@Entity(name="store")
@Getter
@Setter
@SQLDelete(sql = "UPDATE store SET removed_at = NOW() WHERE id=?")
public class StoreEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String name;
    @Column(nullable = false) private String address;
    @Column(nullable = false) private Double latitude;
    @Column(nullable = false) private Double longitude;

    private StoreEntity(String name, String address, Double latitude, Double longitude) {
        this.name = name;
        this.address = address;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    protected StoreEntity(){}

    public static StoreEntity of(String name, String address, Double latitude, Double longitude){
        return new StoreEntity(name, address, latitude, longitude);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StoreEntity that = (StoreEntity) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
