package com.karma.voucher.model.user;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Table;
import java.io.Serializable;

@Getter
@Setter
@ToString
@Table(name="user_group_mapping_id")
public class UserGroupMappingIdEntity implements Serializable {
    private String userGroupId;
    private String userId;
}
