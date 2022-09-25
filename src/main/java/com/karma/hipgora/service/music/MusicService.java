package com.karma.hipgora.service.music;

import com.karma.hipgora.utils.FileUploadUtil;
import com.karma.hipgora.utils.StaticFilesDirs;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class MusicService {

    private static FileUploadUtil fileUploadUtil;

    public void uploadMusic(MultipartFile music, MultipartFile thumbnail) throws IOException {
        // 음악파일, 썸네일 저장
        fileUploadUtil.saveFile(StaticFilesDirs.UPLOAD_MUSICS, music);
        fileUploadUtil.saveFile(StaticFilesDirs.UPLOAD_THUMBNAIL, thumbnail);
    }
}
