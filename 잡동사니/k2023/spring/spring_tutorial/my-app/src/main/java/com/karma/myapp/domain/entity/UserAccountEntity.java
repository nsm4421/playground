package com.karma.myapp.domain.entity;

import com.karma.myapp.domain.constant.UserRole;
import com.karma.myapp.domain.constant.UserStatus;
import com.karma.myapp.domain.dto.CustomPrincipal;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Getter
@Table(
        name = "USER_ACCOUNT",
        indexes = {
                @Index(columnList = "username"),
                @Index(columnList = "email")
        })
@SQLDelete(sql = "UPDATE USER_ACCOUNT SET removed_at = NOW() WHERE id=?")   // soft delete
@Where(clause = "removed_at is NULL")
@EntityListeners(AuditingEntityListener.class)  // jpa auditing
public class UserAccountEntity {
    /**
     * id : primary key
     * username
     * email
     * password
     * userRole : 향후 권한 설정을 위한 필드 (default : USER)
     * userStatus : 유저 상태 (활동중/차단/비활성화) (default : ACTIVE)
     * memo : 확장성을 고려햐여 유저 정보(Object)를 Stringify 하여 저장한 Text 저장을 위한 컬럼
     * created_at, modified_at, removed_at
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, columnDefinition = "VARCHAR(100) CHARACTER SET UTF8")
    @Setter
    private String username;
    @Column
    @Setter
    private String email;
    @Column
    @Setter
    private String password;
    @Enumerated(EnumType.STRING)
    @Setter
    private UserRole userRole = UserRole.USER;
    @Enumerated(EnumType.STRING)
    @Setter
    private UserStatus userStatus = UserStatus.ACTIVE;
    @Column(columnDefinition = "TEXT")
    @Setter
    private String memo;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @CreatedDate
    @Column(updatable = false, name = "created_at")
    private LocalDateTime createdAt;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    @LastModifiedDate
    @Column(name = "modified_at")
    private LocalDateTime modifiedAt;
    @Column(name = "removed_at")
    @Setter
    private LocalDateTime removedAt;

    private UserAccountEntity(Long id, String username, String email, String password, UserRole userRole, UserStatus userStatus, String memo, LocalDateTime createdAt, LocalDateTime modifiedAt, LocalDateTime removedAt) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.userRole = userRole;
        this.userStatus = userStatus;
        this.memo = memo;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.removedAt = removedAt;
    }

    protected UserAccountEntity() {
    }

    public static UserAccountEntity of(
            String username,
            String email,
            String password,
            String memo,
            UserRole userRole,
            UserStatus userStatus
    ) {
        return new UserAccountEntity(
                null,
                username,
                email,
                password,
                userRole,
                userStatus,
                memo,
                null,
                null,
                null
        );
    }

    public static UserAccountEntity of(
            String username,
            String email,
            String password,
            String memo
    ) {
        return new UserAccountEntity(
                null,
                username,
                email,
                password,
                UserRole.USER,
                UserStatus.ACTIVE,
                memo,
                null,
                null,
                null
        );
    }

    // principal → entity
    public static UserAccountEntity from(CustomPrincipal principal) {
        return new UserAccountEntity(
                principal.getId(),
                principal.getUsername(),
                principal.getEmail(),
                principal.getPassword(),
                principal.getUserRole(),
                principal.getUserStatus(),
                principal.getMemo(),
                principal.getCreatedAt(),
                principal.getModifiedAt(),
                principal.getRemovedAt()
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UserAccountEntity that)) return false;
        return this.getId() != null && this.getId().equals(that.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
