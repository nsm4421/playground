package com.karma.myapp.service;

import com.karma.myapp.domain.constant.AlarmType;
import com.karma.myapp.domain.constant.EmotionConst;
import com.karma.myapp.domain.dto.CustomPrincipal;
import com.karma.myapp.domain.entity.ArticleEntity;
import com.karma.myapp.domain.entity.EmotionEntity;
import com.karma.myapp.domain.entity.UserAccountEntity;
import com.karma.myapp.repository.ArticleRepository;
import com.karma.myapp.repository.EmotionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class EmotionService {
    private final ArticleRepository articleRepository;
    private final EmotionRepository emotionRepository;
    private final AlarmService alarmService;

    /**
     * 내 감정표현 가져오기
     *
     * @param principal 로그인한 유저의 인증정보
     * @param articleId 게시글 id
     * @return
     */
    @Transactional(readOnly = true)
    public EmotionConst getMyEmotion(CustomPrincipal principal, Long articleId) {
        UserAccountEntity user = UserAccountEntity.from(principal);
        ArticleEntity article = articleRepository.getReferenceById(articleId);
        Optional<EmotionEntity> emotion = emotionRepository.findByUserAndArticle(user, article);
        return emotion.map(EmotionEntity::getEmotion).orElse(null);
    }

    /**
     * 게시글의 감정표현 개수
     *
     * @param articleId 게시글 id
     * @return count map
     */
    @Transactional(readOnly = true)
    public Map<EmotionConst, Long> getCountMap(Long articleId) {
        HashMap<EmotionConst, Long> countMap = new HashMap<EmotionConst, Long>();
        for (Object[] o : emotionRepository.getCountMap(articleRepository.getReferenceById(articleId))) {
            EmotionConst emotion = EmotionConst.valueOf(String.valueOf(o[0]));
            Long cnt = Long.parseLong(o[1].toString());
            countMap.put(emotion, cnt);
        }
        for (EmotionConst e : EmotionConst.values()) {
            if (!countMap.containsKey(e)) {
                countMap.put(e, 0L);
            }
        }
        return countMap;
    }

    /**
     * 감정표현 저장
     *
     * @param principal 로그인한 유저의 인증정보
     * @param emotion   감정표현
     * @param articleId 게시글 id
     */
    public void handleEmotion(CustomPrincipal principal, EmotionConst emotion, Long articleId) {
        UserAccountEntity user = UserAccountEntity.from(principal);
        ArticleEntity article = articleRepository.getReferenceById(articleId);
        emotionRepository.findByUserAndArticle(user, article).ifPresentOrElse(it -> {
            // 이미 같은 감정표현이 있는 경우 → 삭제
            if (it.getEmotion().equals(emotion)) {
                emotionRepository.delete(it);
            }
            // 이미 다른 감정표현이 있는 경우 → 변경
            else {
                it.setEmotion(emotion);
                emotionRepository.save(it);
            }
        }, () -> {
            // 기존에 감정표현이 없는 경우 → 저장 & 알림
            EmotionEntity entity = emotionRepository.save(EmotionEntity.of(emotion, user, article));
            // 글쓴이와 좋아요 누른 사람이 다른 경우에 알람기능 사용
            if (!user.equals(article.getUser())) {
                alarmService.sendAlarm(
                        alarmService.saveAlarm(
                                article.getUser(),
                                AlarmType.NEW_EMOTION_ON_ARTICLE,
                                String.format("%s express emotion on your article", user.getUsername()),
                                "{" +
                                        "\"username\":" + "\"" + user.getUsername() + "\"" + "," +
                                        "\"articleId\":" + "\"" + articleId + "\"" + "," +
                                        "\"title\":" + "\"" + article.getTitle() + "\"" + "," +
                                        "\"createdAt\":" + "\"" + entity.getCreatedAt() + "\"" + "," +
                                        "\"emotion\":" + "\"" +  emotion.name() + "\""  +
                                        "}"
                        ));
            }
        });
    }
}
