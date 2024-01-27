package com.karma.commerce.domain;

import jakarta.persistence.Column;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Getter
@ToString
@EntityListeners(AuditingEntityListener.class)
@MappedSuperclass
public abstract class AuditingFields {
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate
    @Column(updatable = false, name = "created_at")
    private LocalDateTime createdAt;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @LastModifiedDate
    @Column(name = "modified_at")
    private LocalDateTime modifiedAt;
    @CreatedBy
    @Column(updatable = false, length = 100, name = "created_by")
    private String createdBy;
    @LastModifiedBy
    @Column(length = 100, name = "modified_by")
    private String modifiedBy;
    @Column(name = "removed_at") @Setter
    private LocalDateTime removedAt;
}
