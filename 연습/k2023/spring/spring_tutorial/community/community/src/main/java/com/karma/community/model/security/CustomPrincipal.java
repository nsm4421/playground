package com.karma.community.model.security;

import com.karma.community.model.dto.UserAccountDto;
import com.karma.community.model.util.RoleType;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public record CustomPrincipal(
        String username,
        String password,
        Collection<? extends GrantedAuthority> authorities,
        String email,
        String nickname,
        String description,
        Map<String, Object> oAuthAttributes
) implements UserDetails, OAuth2User {

    public static CustomPrincipal of(String username, String password, String email, String nickname, String description, Map<String, Object> oAuthAttributes) {
        Set<RoleType> roleTypes = Set.of(RoleType.USER);

        return new CustomPrincipal(
                username,
                password,
                roleTypes.stream()
                        .map(RoleType::getName)
                        .map(SimpleGrantedAuthority::new)
                        .collect(Collectors.toUnmodifiableSet())
                ,
                email,
                nickname,
                description,
                oAuthAttributes
        );
    }

    public static CustomPrincipal of(String username, String password, String email, String nickname, String description) {
        return of(username,password,email,nickname,description, Map.of());
    }

    public static CustomPrincipal from(UserAccountDto dto) {
        return CustomPrincipal.of(
                dto.username(),
                dto.password(),
                dto.email(),
                dto.nickname(),
                dto.description()
        );
    }

    public UserAccountDto toDto() {
        return UserAccountDto.of(
                username,
                password,
                email,
                nickname,
                description
        );
    }

    /**
     * Methods to override for spring security
     */
    @Override public String getUsername() { return username; }
    @Override public String getPassword() { return password; }

    @Override public Collection<? extends GrantedAuthority> getAuthorities() { return authorities; }
    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return true; }

    /**
     * Methods to override for oauth2
     */
    @Override
    public Map<String, Object> getAttributes() {
        return oAuthAttributes;
    }
    @Override
    public String getName() {return username;}
}