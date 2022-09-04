package com.sns.karma.repository.feed;

import com.sns.karma.domain.feed.FeedEntity;
import com.sns.karma.domain.user.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FeedRepository extends JpaRepository<FeedEntity, Long> {

}
