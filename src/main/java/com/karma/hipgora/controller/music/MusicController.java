package com.karma.hipgora.controller.music;

import com.karma.hipgora.controller.MyResponse;
import com.karma.hipgora.service.music.MusicService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


@RestController
@RequiredArgsConstructor
public class MusicController {
    private final MusicService musicService;
    @PostMapping(value="/api/v1/music")
    public MyResponse<Void> uploadMusic(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("music") MultipartFile music,
            @RequestParam("thumbnail") MultipartFile thumbnail) throws IOException{

        musicService.uploadMusic(title, description, music, thumbnail);
        return MyResponse.success();
    }
}
