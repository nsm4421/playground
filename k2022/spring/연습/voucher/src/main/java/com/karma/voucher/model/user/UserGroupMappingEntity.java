package com.karma.voucher.model.user;

import com.karma.voucher.model.AuditingFields;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@ToString
@Table(name="user_group_mapping")
@IdClass(UserGroupMappingIdEntity.class)
public class UserGroupMappingEntity extends AuditingFields {
    /*
        UserGroupMappingId Entity의 userId, userGroupId 라는 field로 PK설정
     */
    @Id private String userId;
    @Id private String userGroupId;

    private String userGroupName;
    private String description;
}
