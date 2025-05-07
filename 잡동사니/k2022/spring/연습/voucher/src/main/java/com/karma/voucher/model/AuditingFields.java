package com.karma.voucher.model;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class AuditingFields {
    @CreatedDate @Column(updatable = false,nullable = false)
    private LocalDateTime createdAt;

    @LastModifiedBy @Column
    private LocalDateTime modifiedAt;
}
