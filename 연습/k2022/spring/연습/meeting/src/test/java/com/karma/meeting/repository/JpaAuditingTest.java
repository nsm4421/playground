package com.karma.meeting.repository;

import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.model.util.RoleType;
import com.karma.meeting.model.util.Sex;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
class JpaAuditingTest {

    private final UserAccountRepository repository;
    JpaAuditingTest(@Autowired UserAccountRepository repository) {
        this.repository = repository;
    }

    @Test
    public void userAccountJpaAuditingTest() throws Exception{
        //given
        LocalDateTime now = LocalDateTime.now();
        repository.save(
                UserAccount.of(
                        "karma",
                        "nsm4421",
                        Sex.MALE,
                        "1221",
                        "email",
                        RoleType.ADMIN,
                        "description",
                        LocalDate.of(1995, 12,21)
                )
        );

        //when
//        UserAccount saved = repository.findByUsername("karma").orElseThrow();

        // then
//        assertThat(saved.getCreatedAt()).isAfter(now);
//        assertThat(saved.getModifiedAt()).isAfter(now);
    }
}