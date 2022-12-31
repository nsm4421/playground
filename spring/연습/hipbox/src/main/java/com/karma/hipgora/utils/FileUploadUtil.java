package com.karma.hipgora.utils;

import com.karma.hipgora.exception.ErrorCode;
import com.karma.hipgora.exception.MyException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class FileUploadUtil {

    public static Map<String, String> saveFile(StaticFilesDirs staticFilesDirs, MultipartFile multipartFile) throws IOException {

        String originalFilename = multipartFile.getOriginalFilename();
        Map<String, String> map = new HashMap<>();
        
        // 빈 파일인 경우
        if (originalFilename == ""){
            return map;
        }

        // 현재 프로젝트 경로
        String projectDir = System.getProperty("user.dir");

        // 파일 저장 경로
        String saveDir = String.format("%s\\%s", projectDir, staticFilesDirs.getPath());

        // 파일명 생성 - 난수 + "_" + 원래 파일명
        UUID uuid = UUID.randomUUID();
        String savingFilename = String.format("%s_%s", uuid.toString(), originalFilename);
        
        // 저장
        File file = new File(saveDir, savingFilename);
        multipartFile.transferTo(file);

        // 파일명, 저장경로 Return
        map.put("filename", savingFilename);
        map.put("fileDir", saveDir);
        return map;
    }
}
