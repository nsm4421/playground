package com.karma.meeting.service;

import com.karma.meeting.model.dto.FeedDto;
import com.karma.meeting.model.entity.Feed;
import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.repository.FeedRepository;
import com.karma.meeting.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityNotFoundException;

@Service
@Slf4j
@Transactional
@RequiredArgsConstructor
public class FeedService {
    private final UserAccountRepository userAccountRepository;
    private final FeedRepository feedRepository;

    public Page<FeedDto> getFeedPage(Pageable pageable){
        return feedRepository.findAll(pageable).map(FeedDto::from);
    }

    public FeedDto getFeed(Long feedId){
        return feedRepository.findById(feedId).map(FeedDto::from)
                .orElseThrow(()->{throw new EntityNotFoundException(String.format("Feed(id:[%s]) is not founded...", feedId));});
    }

    public void addFeed(String title, String content, String username){
        UserAccount userAccount = userAccountRepository.findByUsername(username)
                        .orElseThrow(()->{throw new UsernameNotFoundException(String.format("Username [%s] is not founded...", username));});
        feedRepository.save(Feed.of(title, content, userAccount, null));
    }

    public void modifyFeed(Long feedId, String title, String content){
        Feed feed = feedRepository.findById(feedId)
                .orElseThrow(()->{throw new EntityNotFoundException(String.format("Feed(id:[%s]) is not founded...", feedId));});
        feed.setTitle(title);
        feed.setContent(content);
        feedRepository.saveAndFlush(feed);
    }

    public void deleteFeed(Long feedId){
        feedRepository.deleteById(feedId);
    }
}
