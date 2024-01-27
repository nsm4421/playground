package com.karma.compass.store.repository

import com.karma.compass.AbstractIntegrationBaseTest
import com.karma.compass.domain.entity.StoreEntity
import com.karma.compass.repository.StoreEntityRepository
import org.springframework.beans.factory.annotation.Autowired

import java.time.LocalDateTime

class StoreEntityRepositoryTest extends AbstractIntegrationBaseTest {
    @Autowired StoreEntityRepository storeEntityRepository;

    def setup(){
        storeEntityRepository.deleteAll();
    }

    def "Save Entity, Check Fields"(){
        given:
            String address = "서울특별시 동작구 상도동"
            String name = "할리스커피"
            Double latitude = 12
            Double longitude = 12
            def store = StoreEntity.of(name, address, latitude, longitude);

        when:
            def saved = storeEntityRepository.save(store)

        then:
            saved.getAddress() == store.getAddress()
            saved.getName() == store.getName()
            saved.getLatitude() == store.getLatitude()
            saved.getLongitude() == store.getLongitude()
    }

    def "Save Entity, Check Count"(){
        given:
            String address = "서울특별시 동작구 상도동"
            String name = "할리스커피"
            Double latitude = 12
            Double longitude = 12
            def store = StoreEntity.of(name, address, latitude, longitude);

        when:
            def cntBeforeSave = storeEntityRepository.findAll().size();
            def saved = storeEntityRepository.saveAll(Arrays.asList(store))
            def cntAfterSave = storeEntityRepository.findAll().size();

        then:
            cntAfterSave == cntBeforeSave+1
    }

    def "Jpa Auditing Test"(){
        given:
            LocalDateTime now = LocalDateTime.now();
            String address = "서울특별시 동작구 상도동"
            String name = "할리스커피"
            Double latitude = 12
            Double longitude = 12
            def store = StoreEntity.of(name, address, latitude, longitude);
        when:
            storeEntityRepository.save(store)
            def saved = storeEntityRepository.findAll().get(0)
        then:
            !Objects.isNull(saved.getCreatedAt())
            saved.getCreatedAt().isAfter(now)
    }
}
