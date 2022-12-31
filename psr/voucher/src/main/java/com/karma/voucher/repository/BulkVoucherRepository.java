package com.karma.voucher.repository;

import com.karma.voucher.model.bulk.BulkVoucherEntity;
import com.karma.voucher.model.bulk.BulkVoucherStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface BulkVoucherRepository extends JpaRepository<BulkVoucherEntity, Integer> {
    List<BulkVoucherEntity> findByStatusAndStartAtGreaterThan(BulkVoucherStatus status, LocalDateTime startAt);
}
