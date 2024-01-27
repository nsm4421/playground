package com.karma.myapp.controller.request;

import lombok.Data;

@Data
public class ModifyUserInfoRequest {
    private String password;
    private String email;
    private String memo;
}
