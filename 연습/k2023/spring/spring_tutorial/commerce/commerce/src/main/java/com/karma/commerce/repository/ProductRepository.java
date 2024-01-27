package com.karma.commerce.repository;

import com.karma.commerce.domain.constant.Category;
import com.karma.commerce.domain.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Transactional
public interface ProductRepository extends JpaRepository<ProductEntity, Long> {
    @Transactional(readOnly = true)
    Page<ProductEntity> findAll(Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByCategory(Category category, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByNameContaining(String name, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByHashtags(String hashtag, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByDescriptionContaining(String description, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByNameContainingAndCategory(String name, Category category, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByDescriptionContainingAndCategory(String description, Category category, Pageable pageable);

    @Transactional(readOnly = true)
    Page<ProductEntity> findByHashtagsAndCategory(String hashtag, Category category, Pageable pageable);
}
