package com.karma.commerce.service;

import com.karma.commerce.domain.constant.Category;
import com.karma.commerce.domain.dto.ProductDto;
import com.karma.commerce.domain.entity.ProductEntity;
import com.karma.commerce.domain.constant.SearchType;
import com.karma.commerce.repository.ProductRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public Page<ProductDto> getProducts(Category category, SearchType searchType, String keyword, Pageable pageable) {
        // no category & no search
        if (category == null && searchType == null) {
            return productRepository.findAll(pageable).map(ProductDto::from);
        }
        // category & no search
        if (searchType == null) {
            return productRepository.findByCategory(category, pageable).map(ProductDto::from);
        }
        // no category & search
        if (category == null) {
            return switch (searchType) {
                case NAME -> productRepository.findByNameContaining(keyword, pageable).map(ProductDto::from);
                case DESCRIPTION ->
                        productRepository.findByDescriptionContaining(keyword, pageable).map(ProductDto::from);
                case HASHTAG -> productRepository.findByHashtags(keyword, pageable).map(ProductDto::from);
            };
        }
        // category & search
        return switch (searchType) {
            case NAME ->
                    productRepository.findByNameContainingAndCategory(keyword, category, pageable).map(ProductDto::from);
            case DESCRIPTION ->
                    productRepository.findByDescriptionContainingAndCategory(keyword, category, pageable).map(ProductDto::from);
            case HASHTAG ->
                    productRepository.findByHashtagsAndCategory(keyword, category, pageable).map(ProductDto::from);
        };
    }

    @Transactional(readOnly = true)
    public ProductDto getProduct(Long id) {
        return ProductDto.from(productRepository.findById(id).orElseThrow(() -> {
            throw new EntityNotFoundException("Invalid product id is given");
        }));
    }

    public ProductDto updateProduct(Long id, String description) {
        ProductEntity entity = productRepository.findById(id).orElseThrow(() -> {
            throw new EntityNotFoundException("Invalid product id is given");
        });
        entity.setDescription(description);
        return ProductDto.from(productRepository.save(entity));
    }
}