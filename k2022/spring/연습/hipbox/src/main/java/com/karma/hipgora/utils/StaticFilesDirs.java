package com.karma.hipgora.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum StaticFilesDirs {
    UPLOAD_MUSICS("src\\main\\resources\\static\\files\\musics"),
    UPLOAD_THUMBNAIL("src\\main\\resources\\static\\files\\thumbnails");
    private String path;
}
