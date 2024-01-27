package com.karma.meeting.model.util;

import com.karma.meeting.model.entity.UserAccount;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDate;
import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Getter
public class CustomPrincipal implements UserDetails {
    private String email;
    private String username;
    private String nickname;
    private Sex sex;
    private String password;
    private Collection<? extends GrantedAuthority> authorities;
    private String description;
    private LocalDate birthAt;

    private CustomPrincipal(String email, String username, String nickname, Sex sex, String password, Collection<? extends GrantedAuthority> authorities, String description, LocalDate birthAt) {
        this.email = email;
        this.username = username;
        this.nickname = nickname;
        this.sex = sex;
        this.password = password;
        this.authorities = authorities;
        this.description = description;
        this.birthAt = birthAt;
    }

    protected CustomPrincipal(){}

    public static CustomPrincipal of(String email, String username, String nickname, Sex sex, String password, RoleType roleType, String description, LocalDate birthAt){
        return new CustomPrincipal(email,username,nickname,sex,password, typeCastingForRoleType(roleType), description, birthAt);
    }
    public static CustomPrincipal from(UserAccount userAccount){
        return CustomPrincipal.of(
                userAccount.getEmail(), userAccount.getUsername(), userAccount.getNickname(), userAccount.getSex(),
                userAccount.getPassword(), userAccount.getRoleType(), userAccount.getDescription(), userAccount.getBirthAt()
        );
    }
    private static Collection<? extends GrantedAuthority> typeCastingForRoleType(RoleType roleType){
        return  Stream.of(roleType)
                .map(RoleType::getDescription)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toUnmodifiableSet());
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
