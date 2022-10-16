package com.karma.voucher.repository;

import com.karma.voucher.model.voucher.VoucherEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoucherRepository extends JpaRepository<VoucherEntity, Integer> {
}
