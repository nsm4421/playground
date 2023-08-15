package com.karma.myapp.domain.constant;


import jakarta.persistence.Column;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
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
public class BaseEntity {
    /**
     * createdAt : 생성한 시간
     * createdBy : 생성한 유저의 username
     * modifiedAt : 수정한 시간
     * modifiedBy : 수정한 유저의 username
     * removedAt : 삭제된 시간
     */
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @CreatedDate
    @Column(nullable = false, updatable = false, name = "created_at")
    private LocalDateTime createdAt; 

    @CreatedBy
    @Column(nullable = false, updatable = false, length = 100, name = "created_by")
    private String createdBy;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @LastModifiedDate
    @Column(nullable = false, name = "modified_at")
    private LocalDateTime modifiedAt;

    @LastModifiedBy
    @Column(nullable = false, length = 100, name = "modified_by")
    private String modifiedBy; 

    @Column(name = "removed_at")
    private LocalDateTime removedAt;
}
