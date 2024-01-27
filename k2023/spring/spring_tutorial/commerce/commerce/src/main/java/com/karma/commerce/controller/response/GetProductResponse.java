package com.karma.commerce.controller.response;

import com.karma.commerce.domain.constant.Category;
import com.karma.commerce.domain.dto.ProductDto;
import lombok.Data;

@Data
public class GetProductResponse {
    private Long id;
    private String name;
    private String imgUrl;
    private Category category;
    private String description;
    private Long price;

    private GetProductResponse(Long id, String name, String imgUrl, Category category, String description, Long price) {
        this.id = id;
        this.name = name;
        this.imgUrl = imgUrl;
        this.category = category;
        this.description = description;
        this.price = price;
    }

    protected GetProductResponse(){}

    private static GetProductResponse of(Long id, String name, String imgUrl, Category category, String description, Long price){
        return new GetProductResponse(id, name, imgUrl, category, description, price);
    }

    public static GetProductResponse from(ProductDto dto){
        return GetProductResponse.of(
                dto.id(),
                dto.name(),
                dto.imgUrl(),
                dto.category(),
                dto.description(),
                dto.price()
        );
    }
}
