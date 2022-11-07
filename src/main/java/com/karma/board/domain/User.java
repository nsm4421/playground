package com.karma.board.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Entity
@ToString
@Table(indexes = {
        @Index(columnList = "email", unique = true),
        @Index(columnList = "username", unique = true),
        @Index(columnList = "createdAt"),
        @Index(columnList = "createdBy")
})
public class User extends AuditingFields{
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

    protected User(){}

    private User(String email, String username, String password, String description) {
        this.email = email;
        this.username = username;
        this.password = password;
        this.description = description;
    }

    public static User of(String email, String username, String password, String description){
        return new User(email, username, password, description);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User that = (User) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
