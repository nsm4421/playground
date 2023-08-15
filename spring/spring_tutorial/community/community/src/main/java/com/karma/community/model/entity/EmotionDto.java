package com.karma.community.model.entity;

import com.karma.community.model.dto.ArticleDto;
import com.karma.community.model.dto.UserAccountDto;
import com.karma.community.model.util.EmotionType;
import lombok.Getter;

@Getter
public class EmotionDto {
    private ArticleDto articleDto;
    private UserAccountDto userAccountDto;
    private EmotionType emotionType;

    private EmotionDto(ArticleDto articleDto, UserAccountDto userAccountDto, EmotionType emotionType) {
        this.articleDto = articleDto;
        this.userAccountDto = userAccountDto;
        this.emotionType = emotionType;
    }

    protected EmotionDto(){}

    public static EmotionDto of(ArticleDto articleDto, UserAccountDto userAccountDto, EmotionType emotionType){
        return new EmotionDto(articleDto, userAccountDto, emotionType);
    }

    public static EmotionDto from(Emotion entity){
        return EmotionDto.of(
                ArticleDto.from(entity.getArticle()),
                UserAccountDto.from(entity.getUserAccount()),
                entity.getEmotionType()
        );
    }
}
