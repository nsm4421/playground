package com.karma.prj.service;

import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.exception.CustomException;
import com.karma.prj.model.entity.PostEntity;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.repository.PostRepository;
import com.karma.prj.repository.UserRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@SpringBootTest
@DisplayName("[PostService]")
class PostServiceTest {
    @Autowired PostService postService;
    @MockBean PostRepository postRepository;
    @MockBean UserRepository userRepository;

    @Test
    @DisplayName("[Create]Success")
    void 포스트작성_성공(){
        String title = "테스트_제목";
        String content = "테스트_본문";
        String username = "테스트_유저명";
        when(userRepository.findByUsername(username)).thenReturn(Optional.of(mock(UserEntity.class)));
        when(postRepository.save(any())).thenReturn(mock(PostEntity.class));
        Assertions.assertDoesNotThrow(()->postService.createPost(title,content,username));
    }

    @Test
    @DisplayName("[Create]Fail since not authenticated")
    void 존재하지않는_유저명으로_포스트작성(){
        String title = "테스트_제목";
        String content = "테스트_본문";
        String username = "테스트_유저명";
        when(userRepository.findByUsername(username)).thenReturn(Optional.empty());     // ← 존재하지 않는 유저명
        when(postRepository.save(any())).thenReturn(mock(PostEntity.class));
        CustomException errorThrown = Assertions.assertThrows(CustomException.class, ()->postService.createPost(title,content,username));
        Assertions.assertEquals(errorThrown.getCode(), CustomErrorCode.USERNAME_NOT_FOUND);
    }
}