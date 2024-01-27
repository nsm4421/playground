package com.karma.voucher.model.bulk;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Entity
@Table(name = "bulk_voucher")
public class BulkVoucherEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Integer id;
    @Column private Integer programId;
    @Column private String userGroupId;
    @Enumerated(EnumType.STRING) private BulkVoucherStatus status;
    @Column private Integer count;
    @Column private LocalDateTime startAt;
    @Column private LocalDateTime endAt;
}
