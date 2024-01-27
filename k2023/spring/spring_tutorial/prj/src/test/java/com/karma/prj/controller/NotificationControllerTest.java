package com.karma.prj.controller;

import com.karma.prj.model.dto.NotificationDto;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.service.UserService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@DisplayName("[Notification]")
@AutoConfigureMockMvc
class NotificationControllerTest {

    @Autowired MockMvc mockMvc;
    @MockBean UserService userService;

    @Test
    @WithMockUser
    @DisplayName("Notification Test")
    void 로그인한_유저_테스트_성공() throws Exception{
        when(userService.findByUsernameOrElseThrow(any())).thenReturn(mock(UserEntity.class));
        mockMvc.perform(get("/api/v1/user/notification")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    @WithAnonymousUser
    @DisplayName("Anonymous user fails test")
    void 로그인_안한_유저_테스트_실패() throws Exception{
        mockMvc.perform(get("/api/v1/user/notification")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isUnauthorized());
    }
}