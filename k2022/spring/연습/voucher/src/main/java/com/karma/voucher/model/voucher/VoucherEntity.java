package com.karma.voucher.model.voucher;

import com.karma.voucher.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Entity
@Table(name = "voucher")
public class VoucherEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column private Integer programId;
    @Column private String userId;

    @Enumerated(EnumType.STRING) private VoucherStatus status = VoucherStatus.NOT_PROGRESSED;
    @Column private Integer remainingCount;

    @Column private LocalDateTime startAt;
    @Column private LocalDateTime endAt;
    @Column private LocalDateTime expiredAt;

    public static VoucherEntity of(Integer programId, String userId, VoucherStatus status, Integer remainingCount,
                            LocalDateTime startAt, LocalDateTime endAt, LocalDateTime expiredAt){
        VoucherEntity voucherEntity = new VoucherEntity();
        voucherEntity.setUserId(userId);
        voucherEntity.setProgramId(programId);
        voucherEntity.setStatus(status);
        voucherEntity.setRemainingCount(remainingCount);
        voucherEntity.setStartAt(startAt);
        voucherEntity.setEndAt(endAt);
        voucherEntity.setExpiredAt(expiredAt);
        return voucherEntity;
    }

}
