package com.karma.community.service;

import com.karma.community.exception.CustomError;
import com.karma.community.exception.CustomErrorCode;
import com.karma.community.model.entity.Article;
import com.karma.community.model.entity.Emotion;
import com.karma.community.model.entity.UserAccount;
import com.karma.community.model.util.EmotionType;
import com.karma.community.repository.ArticleRepository;
import com.karma.community.repository.EmotionRepository;
import com.karma.community.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class EmotionService {
    private final UserAccountRepository userAccountRepository;
    private final ArticleRepository articleRepository;
    private final EmotionRepository emotionRepository;

    public EmotionType getEmotion(Long articleId, String loginUsername) {
        Article article = findArticleById(articleId);
        UserAccount userAccount = findUserByUsername(loginUsername);
        return emotionRepository.findByArticleAndUserAccount(article, userAccount)
                // 감정표현이 없으면 NONE 반환
                .orElseGet(() -> Emotion.of(article, userAccount, EmotionType.NONE))
                .getEmotionType();
    }

    public Map<EmotionType, Long> countEmotion(Long articleId) {
        Article article = findArticleById(articleId);
        HashMap<EmotionType, Long> countMap = new HashMap<>();
        for (EmotionType type : EmotionType.values()){
            countMap.put(type, emotionRepository.countEmotionByArticleAndType(article, type));
        }
        return  countMap;
    }

    public void addEmotion(Long articleId, String loginUsername, EmotionType emotionType) {
        // 요청한 감정표현이 유효한지 확인
        if (emotionType.equals(EmotionType.NONE)) {
            throw CustomError.of(CustomErrorCode.INVALID_INPUT);
        }
        Article article = findArticleById(articleId);
        UserAccount userAccount = findUserByUsername(loginUsername);
        emotionRepository
                .findByArticleAndUserAccount(article, userAccount)
                .ifPresentOrElse(
                        // 기존에 존재하는 감정표현이 있으면 수정
                        it -> {
                            it.setEmotionType(emotionType);
                            emotionRepository.save(it);
                        },
                        // 기존에 존재하는 감정표현이 없으면 저장
                        () -> {
                            emotionRepository.save(Emotion.of(article, userAccount, emotionType));
                        }
                );
    }

    public void cancelEmotion(Long articleId, String loginUsername) {
        // Entity 생성
        Article article = findArticleById(articleId);
        UserAccount userAccount = findUserByUsername(loginUsername);
        emotionRepository.findByArticleAndUserAccount(article, userAccount).ifPresentOrElse(
                // 기존에 있는 감정표현 삭제
                it -> {
                    emotionRepository.deleteById(it.getEmotionId());
                // 기존에 있는 감정표현이 없으면 에러처리
                }, () -> {
                    throw CustomError.of(CustomErrorCode.USER_NOT_FOUND);
                }
        );
    }

    private UserAccount findUserByUsername(String username) {
        return userAccountRepository.findByUsername(username).orElseThrow(() -> {
            throw CustomError.of(CustomErrorCode.USER_NOT_FOUND);
        });
    }

    private Article findArticleById(Long articleId) {
        return articleRepository.findById(articleId).orElseThrow(() -> {
            throw CustomError.of(CustomErrorCode.ARTICLE_NOT_FOUND);
        });
    }
}
