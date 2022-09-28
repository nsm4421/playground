package com.karma.hipgora.controller.music;

import com.karma.hipgora.controller.MyResponse;
import com.karma.hipgora.service.music.MusicService;
import com.karma.hipgora.utils.FileUploadUtil;
import com.karma.hipgora.utils.StaticFilesDirs;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Optional;
import java.util.Set;

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
