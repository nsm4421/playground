package com.karma.compass.domain.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@ToString
@EntityListeners(AuditingEntityListener.class)
@MappedSuperclass
@Where(clause = "removed_at is NULL")
public abstract class AuditingFields {
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate
    private LocalDateTime createdAt;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @LastModifiedDate
    private LocalDateTime modifiedAt;
    private LocalDateTime removedAt;

    // TODO : 인증기능 구현 및 Jpa 설정 변경 후 주석제거
//    @CreatedBy @Column(updatable = false)
//    private String createdBy;
//    @LastModifiedBy
//    private String modifiedBy;
}
