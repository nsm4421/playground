package com.karma.meeting.controller.request;

import com.karma.meeting.model.util.Sex;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RegisterRequest {
    private String username;
    private String nickname;
    private String password;
    private String email;
    private Sex sex;
    private String description;
    private LocalDate birthAt;
}
