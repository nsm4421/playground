package com.karma.myapp.domain.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import com.karma.myapp.domain.constant.UserRole;
import com.karma.myapp.domain.constant.UserStatus;
import com.karma.myapp.domain.entity.UserAccountEntity;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomPrincipal implements UserDetails {
    private Long id;
    private String username;
    private String email;
    private String password;
    private UserRole userRole;
    private UserStatus userStatus;
    private String memo;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime createdAt;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime modifiedAt;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime removedAt;

    private CustomPrincipal(Long id, String username, String email, String password, UserRole userRole, UserStatus userStatus, String memo, LocalDateTime createdAt, LocalDateTime modifiedAt, LocalDateTime removedAt) {
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

    protected CustomPrincipal() {
    }

    public static CustomPrincipal of(String username, String email, String password, UserRole userRole, UserStatus userStatus, String memo) {
        return new CustomPrincipal(null, username, email, password, userRole, userStatus, memo, null, null, null);
    }

    public static CustomPrincipal from(UserAccountEntity entity) {
        return new CustomPrincipal(
                entity.getId(),
                entity.getUsername(),
                entity.getEmail(),
                entity.getPassword(),
                entity.getUserRole(),
                entity.getUserStatus(),
                entity.getMemo(),
                entity.getCreatedAt(),
                entity.getModifiedAt(),
                entity.getRemovedAt()
        );
    }

    @Override
    @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Stream.of(userRole)
                .map(UserRole::getName)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toUnmodifiableSet());
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonLocked() {
        return !userStatus.equals(UserStatus.BLOCKED);
    }

    @Override
    @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    @JsonIgnore
    public boolean isEnabled() {
        return removedAt == null && !userStatus.equals(UserStatus.BLOCKED);
    }
}
