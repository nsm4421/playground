package com.karma.hipgora.controller.music;

import com.karma.hipgora.controller.MyResponse;
import com.karma.hipgora.service.music.MusicService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Set;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/music")
public class MusicController {
    private final MusicService musicService;
    @PostMapping
    public MyResponse<Void> uploadMusic(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("music") MultipartFile music,
            @RequestParam("hashtag") Set<String> hashtag,
            @RequestParam("thumbnail") MultipartFile thumbnail,
            Authentication authentication) throws IOException{

        String username = authentication.getName();
        musicService.uploadMusic(title, description, music, thumbnail, username, hashtag);
        return MyResponse.success();
    }
}
