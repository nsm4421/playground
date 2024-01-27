package com.karma.prj.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.model.util.RoleType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.management.relation.Role;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Set;

@Entity
@Getter
@Setter
@Table(name = "\"user\"")
@SQLDelete(sql = "UPDATE \"user\" SET removed_at = NOW() WHERE id=?")
@EntityListeners(AuditingEntityListener.class)
@Where(clause = "removed_at is NULL")
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserEntity implements UserDetails {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    private String email;
    @Column(unique = true)
    private String username;
    @Column(unique = true)
    private String nickname;
    private String password;
    @Enumerated(EnumType.STRING)
    private RoleType role;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate @Column(updatable = false, name = "created_at") @JsonIgnore
    private LocalDateTime createdAt;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @LastModifiedDate @Column(name = "modified_at") @JsonIgnore
    private LocalDateTime modifiedAt;
    @Column(name = "removed_at") @Setter @JsonIgnore
    private LocalDateTime removedAt;

    private UserEntity(String email, String username, String nickname, String password, RoleType role, LocalDateTime createdAt, LocalDateTime removedAt) {
        this.email = email;
        this.username = username;
        this.nickname = nickname;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
        this.removedAt = removedAt;
    }

    protected UserEntity(){}

    public static UserEntity of(String email, String username, String nickname, String password, RoleType role, LocalDateTime createdAt, LocalDateTime removedAt) {
        return new UserEntity(email, username, nickname, password, role, createdAt, removedAt);
    }

    public static UserDto dto(UserEntity entity){
        return UserDto.of(
                entity.getEmail(),
                entity.getUsername(),
                entity.getNickname(),
                entity.getPassword(),
                entity.getRole(),
                entity.getCreatedAt(),
                entity.getRemovedAt()
        );
    }

    @Override @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Set.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override @JsonIgnore
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override @JsonIgnore
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override @JsonIgnore
    public boolean isEnabled() {
        return true;
    }
}
