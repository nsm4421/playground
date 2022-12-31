package com.karma.voucher.repository;

import com.karma.voucher.model.program.ProgramEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface ProgramRepository extends JpaRepository<ProgramEntity, Integer> {

    @Transactional
    @Modifying
    @Query(value = "UPDATE ProgramEntity pe " +
                "SET pe.count = :count, pe.period = :period " +
                "WHERE pe.id = :id")
    Integer updateCountAndPeriodById(Integer id, Integer count, Integer period);

}
