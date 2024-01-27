package com.sns.karma.model.user;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.stereotype.Indexed;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.Instant;

@Setter
@Getter
@Entity
@Table(name = "\"users\"",
        indexes = {
                @Index(columnList = "user_name")
                ,@Index(columnList = "state")
})
@SQLDelete(sql = "UPDATE \"user\" SET removed_at = NOW() WHERE id=?")
@Where(clause = "removed_at is NULL")
@NoArgsConstructor
public class UserEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id = null;
    @Column(unique = true, nullable = false) private String email;
    @Column(name = "user_name", unique = true, nullable = false) private String userName;
    @Column private String password;
    @Enumerated(EnumType.STRING) private Provider provider = Provider.EMAIL;
    @Enumerated(EnumType.STRING) private Role role = Role.USER;
    @Enumerated(EnumType.STRING) private State state = State.ACTIVE;
    @Column(name = "registered_at")  private Timestamp registeredAt;
    @Column(name = "updated_at") private Timestamp updatedAt;
    @Column(name = "removed_at") private Timestamp removedAt;


    @PrePersist
    void registeredAt() {
        this.registeredAt = Timestamp.from(Instant.now());
    }

    @PreUpdate
    void updatedAt() {
        this.updatedAt = Timestamp.from(Instant.now());
    }

    public static UserEntity of(String email, String userName, String password, Provider provider) {
        UserEntity userEntity = new UserEntity();
        userEntity.setEmail(email);
        userEntity.setUserName(userName);
        userEntity.setPassword(password);
        userEntity.setProvider(provider);
        return userEntity;
    }
}