package com.karma.compass.service;

import com.karma.compass.domain.dto.StoreDto;
import com.karma.compass.domain.entity.StoreEntity;
import com.karma.compass.repository.StoreEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StoreService {
    private final StoreEntityRepository storeEntityRepository;

    @Transactional(readOnly = true)
    private List<StoreEntity> findAll(){
        return storeEntityRepository.findAll();
    }

    @Transactional(readOnly = true)
    private Page<StoreEntity> findAll(Pageable pageable){
        return storeEntityRepository.findAll(pageable);
    }

    public List<StoreDto> getDtoList(){
        return this.findAll().stream().map(StoreDto::from).collect(Collectors.toList());
    }
}