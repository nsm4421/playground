package com.sns.karma.controller.feed;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sns.karma.controller.feed.request.WriteFeedRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class FeedControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @Test
    @WithMockUser   // <- 로그인한 경우
    @DisplayName("[Write]정상 피드작성")
    void givenTitleAndBody_whenWriteFeed_thenHandle() throws Exception{
        String title = "test_title";
        String body = "test_body";
        mockMvc.perform(
               post("api/v1/feed")
                       .contentType(MediaType.APPLICATION_JSON)
                       .content(objectMapper.writeValueAsBytes(new WriteFeedRequest(title, body))))
                .andExpect(status().isOk());
    }

    @Test
    @WithAnonymousUser  // <- 로그인되지 않은 경우(익명 유저)
    @DisplayName("[Write]인증되지 않은 사용자가 피드작성")
    void givenTitleAndBody_whenWriteFeedNotAuth_thenThrowError() throws Exception{
        String title = "test_title";
        String body = "test_body";
        mockMvc.perform(
                        post("api/v1/feed")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsBytes(new WriteFeedRequest(title, body))))
                .andExpect(status().isUnauthorized());
    }

}
