package com.karma.board.domain;

import com.karma.board.domain.dto.UserAccountDto;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@Entity
@ToString
@Table(indexes = {
        @Index(columnList = "email", unique = true),
        @Index(columnList = "username", unique = true),
        @Index(columnList = "createdAt")
})
public class UserAccount {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, length = 100) @Setter
    private String email;
    @Column(nullable = false, unique = true, length = 100) @Setter
    private String username;
    @Column(nullable = false, length = 100) @Setter
    private String password;
    @Column @Setter
    private String description;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column
    private RoleType roleType = RoleType.USER;

    protected UserAccount(){}

    private UserAccount(String email, String username, String password, String description, RoleType roleType) {
        this.email = email;
        this.username = username;
        this.password = password;
        this.description = description;
        this.roleType = roleType;
    }

    public static UserAccount of(String email, String username, String password, String description, RoleType roleType){
        return new UserAccount(email, username, password, description, roleType);
    }

    public static UserAccountDto to(UserAccount userAccount){
        return UserAccountDto.of(
                userAccount.getEmail(),
                userAccount.getUsername(),
                userAccount.getPassword(),
                userAccount.getDescription(),
                userAccount.getRoleType()
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserAccount that = (UserAccount) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
