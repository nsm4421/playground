package com.karma.meeting.repository;

import com.karma.meeting.model.entity.Feed;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface FeedRepository extends JpaRepository<Feed, Long> {
}
