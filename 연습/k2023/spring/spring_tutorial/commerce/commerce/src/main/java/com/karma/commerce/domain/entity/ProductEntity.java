package com.karma.commerce.domain.entity;

import com.karma.commerce.domain.AuditingFields;
import com.karma.commerce.domain.constant.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Getter
@Table(name = "product")
@SQLDelete(sql = "UPDATE product SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
public class ProductEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false) @Setter
    private String name;
    @Column(name="img_url")
    private String imgUrl;
    @Enumerated(value = EnumType.STRING)
    private Category category;
    @Column(name="description", columnDefinition = "TEXT") @Setter
    private String description;
    @ElementCollection(fetch = FetchType.LAZY)
    private Set<String> hashtags = new LinkedHashSet<>();
    @Column(name="price") @Setter
    private Long price;

    private ProductEntity(String name, String imgUrl, Category category, String description, Set<String> hashtags, Long price) {
        this.name = name;
        this.imgUrl = imgUrl;
        this.category = category;
        this.description = description;
        this.hashtags = hashtags;
        this.price = price;
    }

    protected ProductEntity(){}

    public static ProductEntity of(String name, String imgUrl, Category category, String description, Set<String> hashtags, Long price){
        return new ProductEntity(name, imgUrl, category, description, hashtags, price);
    }
}
