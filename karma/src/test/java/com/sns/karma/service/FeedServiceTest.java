package com.sns.karma.service;

import com.sns.karma.domain.feed.FeedEntity;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.feed.FeedRepository;
import com.sns.karma.repository.user.UserRepository;
import com.sns.karma.service.feed.FeedService;
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
public class FeedServiceTest {

    @Autowired private FeedService feedService;
    @MockBean private FeedRepository feedRepository;
    @MockBean private UserRepository userRepository;

    @Test
    @DisplayName("[Write]정상 피드작성")
    void givenTitleAndBody_whenWriteFeed_thenHandle() throws Exception{
        String username = "test_username";
        String title = "test_title";
        String body = "test_body";

        when(userRepository.findByUsername(username))
                .thenReturn(Optional.of(mock(UserEntity.class)));
        when(feedRepository.save(any()))
                .thenReturn(Optional.of(mock(FeedEntity.class)));

        Assertions.assertDoesNotThrow(()->feedService.writeFeed(username, title, body));
    }

    @Test
    @DisplayName("[Write]인증되지 않은 사용자가 피드작성")
    void givenTitleAndBody_whenWriteFeedNotAuth_thenThrowError() throws Exception{
        String username = "test_username";
        String title = "test_title";
        String body = "test_body";

        when(userRepository.findByUsername(username))
                .thenReturn(Optional.empty());
        when(feedRepository.save(any()))
                .thenReturn(Optional.of(mock(FeedEntity.class)));

        ErrorCodeEnum errorCode = Assertions
                .assertThrows(CustomException.class, ()->feedService.writeFeed(username, title, body))
                .getErrorCode();

        Assertions.assertEquals(ErrorCodeEnum.USER_NOT_FOUND, errorCode);
    }
}
