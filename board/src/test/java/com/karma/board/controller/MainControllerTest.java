package com.karma.board.controller;

import com.karma.board.config.SecurityConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@Import(SecurityConfig.class)
@WebMvcTest(MainController.class)
class MainControllerTest {

    private final MockMvc mockMvc;

    public MainControllerTest(@Autowired MockMvc mockMvc){
        this.mockMvc = mockMvc;
    }

    @Test
    @DisplayName("Redirection Test")
    void redirectionTest() throws Exception{
        //given - Nothing
        //when & then - Check Redirection Occurs
        mockMvc.perform(get("/"))
                .andExpect(status().is3xxRedirection());

    }
}