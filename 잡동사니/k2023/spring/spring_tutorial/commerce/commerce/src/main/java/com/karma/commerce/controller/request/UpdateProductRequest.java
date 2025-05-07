package com.karma.commerce.controller.request;

import lombok.Data;

@Data
public class UpdateProductRequest {
    private Long id;
    private String description;
}
