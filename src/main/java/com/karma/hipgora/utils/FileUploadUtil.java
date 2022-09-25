package com.karma.hipgora.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class FileUploadUtil {

    public static void saveFile(StaticFilesDirs staticFilesDirs, MultipartFile multipartFile) throws IOException {
        // 현재 프로젝트 경로
        String projectDir = System.getProperty("user.dir");

        // 파일 저장 경로
        String saveDir = String.format("%s\\%s", projectDir, staticFilesDirs.getPath());

        // 파일명 생성 - 난수 + "_" + 원래 파일명
        UUID uuid = UUID.randomUUID();
        String originalFilename = multipartFile.getOriginalFilename();
        String savingFilename = String.format("%s_%s", uuid, originalFilename);
        
        // 저장
        File file = new File(saveDir, savingFilename);
        multipartFile.transferTo(file);
    }
}
