package com.karma.board.domain;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
public class MyPrincipal implements UserDetails {
    private String email;
    private String username;
    private String password;
    private String description;
    private Collection<? extends GrantedAuthority> authorities;

    private MyPrincipal(String email, String username, String password, String description, Collection<? extends GrantedAuthority> authorities) {
        this.email = email;
        this.username = username;
        this.password = password;
        this.description = description;
        this.authorities = authorities;
    }

    public static MyPrincipal of(String email, String username, String password, String description) {
        Set<RoleType> roleTypes = Set.of(RoleType.USER);    // TODO
        Collection<? extends GrantedAuthority> authorities = roleTypes
                .stream()
                .map(RoleType::getName)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toUnmodifiableSet());
        return new MyPrincipal(email, username, password, description, authorities);
    }

    protected MyPrincipal(){}

    //  Principal → Entity
    public UserAccount to(MyPrincipal myPrincipal){
        return UserAccount.of(
                myPrincipal.getEmail(),
                myPrincipal.getUsername(),
                myPrincipal.getPassword(),
                myPrincipal.getDescription(),
                RoleType.USER                       // TODO
        );
    }

    // Entity → Principal
    public static MyPrincipal from(UserAccount userAccount){
        return MyPrincipal.of(
                userAccount.getEmail(),
                userAccount.getUsername(),
                userAccount.getPassword(),
                userAccount.getDescription()
        );
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return false;
    }
}
