package com.karma.commerce.domain.dto;

import com.karma.commerce.domain.constant.Category;
import com.karma.commerce.domain.entity.ProductEntity;

import java.time.LocalDateTime;
import java.util.Set;

public record ProductDto(
        Long id,
        String name,
        String imgUrl,
        Category category,
        String description,
        Long price,
        Set<String> hashtags,
        LocalDateTime createdAt,
        String createdBy,
        LocalDateTime modifiedAt,
        String modifiedBy
) {
    public static ProductDto of(
            String name,
            String imgUrl,
            Category category,
            String description,
            Long price,
            Set<String> hashtags
    ){
        return new ProductDto(
                null,
                name,
                imgUrl,
                category,
                description,
                price,
                hashtags,
                null,
                null,
                null,
                null
        );
    }
    public static ProductDto from(ProductEntity entity){
        return new ProductDto(
                entity.getId(),
                entity.getName(),
                entity.getImgUrl(),
                entity.getCategory(),
                entity.getDescription(),
                entity.getPrice(),
                entity.getHashtags(),
                entity.getCreatedAt(),
                entity.getCreatedBy(),
                entity.getModifiedAt(),
                entity.getModifiedBy()
        );
    }
}
