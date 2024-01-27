package com.karma.meeting.service;

import com.karma.meeting.repository.CommentRepository;
import com.karma.meeting.repository.FeedRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CommentService {
    private final FeedRepository feedRepository;
    private final CommentRepository commentRepository;
}
