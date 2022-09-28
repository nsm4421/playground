package com.karma.hipgora.model.security;

import com.karma.hipgora.model.user.Role;
import com.karma.hipgora.model.user.State;
import com.karma.hipgora.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

@AllArgsConstructor
@Getter
public class MyPrincipal implements UserDetails {
    private String username;
    private String password;
    private String email;
    private State state;
    private Role role;

    // of : 생성자
    public static MyPrincipal of(String username, String password, String email, State state, Role role){
        return new MyPrincipal(username, password, email, state, role);
    }

    // from : DTO → Principal
    public static MyPrincipal from(User user){
        return new MyPrincipal(
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getState(),
                user.getRole()
        );
    }

    // to : Principal → DTO
    public static User to(MyPrincipal myPrincipal){
        return User.of(
                myPrincipal.getUsername(),
                myPrincipal.getPassword(),
                myPrincipal.getEmail(),
                myPrincipal.getState(),
                myPrincipal.getRole()
        );
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<Role> roles = Set.of(role);
        return roles
                .stream()
                .map(Role::getName)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toUnmodifiableSet());
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return state != State.BLOCKED;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return state != State.BLOCKED;
    }
}
