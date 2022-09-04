package com.sns.karma.controller.feed;

import com.sns.karma.controller.Response;
import com.sns.karma.controller.feed.request.WriteFeedRequest;
import com.sns.karma.service.feed.FeedService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/feed")
@RequiredArgsConstructor
public class FeedController {

    private final FeedService feedService;

    @PostMapping("/write")
    public Response<Void> write(@RequestBody WriteFeedRequest writeFeedRequest){
        // Parsing
        String title = writeFeedRequest.getTitle();
        String body = writeFeedRequest.getBody();

        return Response.success(null);
    }
}
