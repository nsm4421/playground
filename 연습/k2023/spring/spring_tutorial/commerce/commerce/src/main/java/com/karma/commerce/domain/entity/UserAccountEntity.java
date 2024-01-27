package com.karma.commerce.domain.entity;

import com.karma.commerce.domain.constant.UserRole;
import com.karma.commerce.domain.constant.UserStatus;
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

@Entity
@Getter
@Table(name = "USER_ACCOUNT")
@SQLDelete(sql = "UPDATE USER_ACCOUNT SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@EntityListeners(AuditingEntityListener.class)
public class UserAccountEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true) @Setter
    private String username;
    @Column(unique = true) @Setter
    private String email;
    @Column(name = "img_url") @Setter
    private String imgUrl;
    @Column @Setter
    private String password;
    @Enumerated(EnumType.STRING) @Setter
    private UserRole userRole = UserRole.USER;
    @Enumerated(EnumType.STRING) @Setter
    private UserStatus userStatus = UserStatus.ACTIVE;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate
    @Column(updatable = false, name = "created_at")
    private LocalDateTime createdAt;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @LastModifiedDate
    @Column(name = "modified_at")
    private LocalDateTime modifiedAt;
    @Column(name = "removed_at") @Setter
    private LocalDateTime removedAt;

    private UserAccountEntity(String username, String email, String imgUrl, String password, UserRole userRole, UserStatus userStatus) {
        this.username = username;
        this.email = email;
        this.imgUrl = imgUrl;
        this.userRole = userRole;
        this.userStatus = userStatus;
    }

    protected UserAccountEntity(){}

    public static UserAccountEntity of(String username, String email, String imgUrl, String password, UserRole userRole, UserStatus userStatus){
        return new UserAccountEntity(username, email, imgUrl, password, userRole, userStatus);
    }
}
