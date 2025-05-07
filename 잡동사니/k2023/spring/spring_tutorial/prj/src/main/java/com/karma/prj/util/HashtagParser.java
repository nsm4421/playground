package com.karma.prj.util;

import org.springframework.context.annotation.Configuration;

import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Configuration
public class HashtagParser {
    /**
     * 해쉬태크 문자열을 set으로 만들어줌
     * Ex) "#사과 #파인애플" → Set.of("사과", "파인애플")
     * @param hashtags : 해쉬태그 String
     * @return 해쉬태그 Set
     */
    public Set<String> stringToSet(String hashtags) {
        if (hashtags == null) {
            return Set.of();
        }
        // #로 시작하고, 한글(가-힣), _ , 영어나 숫자 (\w)만
        Pattern pattern = Pattern.compile("#[\\wㄱ-힣]+");
        // 공백제거
        Matcher matcher = pattern.matcher(hashtags.strip());
        Set<String> result = new HashSet<>();
        while (matcher.find()) {
            result.add(matcher.group().replace("#", ""));
        }
        return result;
    }
}
