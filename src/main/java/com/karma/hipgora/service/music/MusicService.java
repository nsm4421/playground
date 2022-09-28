package com.karma.hipgora.service.music;

import com.karma.hipgora.model.music.MusicEntity;
import com.karma.hipgora.model.user.UserEntity;
import com.karma.hipgora.repository.MusicEntityRepository;
import com.karma.hipgora.utils.FileUploadUtil;
import com.karma.hipgora.utils.StaticFilesDirs;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class MusicService {

    private static FileUploadUtil fileUploadUtil;
    private final MusicEntityRepository musicEntityRepository;

    public void uploadMusic(String title, String description,
                            MultipartFile music, MultipartFile thumbnail) throws IOException {
        // 음악파일, 썸네일 저장
        Map<String, String> musicMap = fileUploadUtil.saveFile(StaticFilesDirs.UPLOAD_MUSICS, music);
        Map<String, String> thumbnailMap = fileUploadUtil.saveFile(StaticFilesDirs.UPLOAD_THUMBNAIL, thumbnail);

        // TODO : 해쉬태그
//        Set<String> hashtags = new HashSet<>();

        // DB에 저장
        MusicEntity musicEntity = MusicEntity.of(
                title, description, musicMap.get("filename"), musicMap.get("fileDir"),
                thumbnailMap.getOrDefault("filename", null),
                thumbnailMap.getOrDefault("fileDir", null));
        musicEntityRepository.save(musicEntity);
    }
}
