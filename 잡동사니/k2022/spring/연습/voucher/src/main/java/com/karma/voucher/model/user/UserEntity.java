package com.karma.voucher.model.user;

import com.karma.voucher.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Table(name="user")

public class UserEntity extends AuditingFields {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;


}
