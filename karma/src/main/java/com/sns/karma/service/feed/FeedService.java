package com.sns.karma.service.feed;

import com.sns.karma.domain.feed.FeedEntity;
import com.sns.karma.domain.user.UserEntity;
import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCodeEnum;
import com.sns.karma.repository.feed.FeedRepository;
import com.sns.karma.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
public class FeedService {

    private final UserRepository userRepository;
    private final FeedRepository feedRepository;
    @Transactional
    public void writeFeed(String username, String title, String body){
        // 1) Check whether username exists in DB or not
        UserEntity userEntity = userRepository.findByUsername(username)
                .orElseThrow(()-> new CustomException(
                        ErrorCodeEnum.USER_NOT_FOUND,
                        String.format("username %s is not founded", username)));

        // 2) Save
        feedRepository.save(new FeedEntity());
        // 3) Return
    }
}
