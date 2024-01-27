package com.karma.compass.util;

import com.karma.compass.domain.dto.KakaoApiResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Recover;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;

@Slf4j
@RequiredArgsConstructor
public class KakaoApiService {
    @Value("${kakao.api.base-url}") private String KAKAO_BASE_URL;
    @Value("${kakao.api.secret-key}") private String KAKAO_SECRET_KEY;
    private final RestTemplate restTemplate;

    public URI buildUri(String address) {
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(KAKAO_BASE_URL);
        uriBuilder.queryParam("query", address);
        URI uri = uriBuilder.build().encode().toUri();
        log.info("KakaoApiService.buildUri - address: [{}], uri: [{}]", address, uri);
        return uri;
    }

    @Retryable(
            value = {RuntimeException.class},   // 에러 종류
            maxAttempts = 2,                    // 최대 시도 횟수
            backoff = @Backoff(delay = 2000)    // 딜레이 시간 (2초)
    )
    public KakaoApiResponseDto searchAddress(String address) {
        if(ObjectUtils.isEmpty(address)) return null;
        URI uri = buildUri(address);
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.AUTHORIZATION, "KakaoAK " + KAKAO_SECRET_KEY);
        return restTemplate
                .exchange(uri, HttpMethod.GET, new HttpEntity<>(headers), KakaoApiResponseDto.class)
                .getBody();
    }

    @Recover
    public KakaoApiResponseDto recover(RuntimeException e, String address){
        log.error("Error occurs... address : [{}] error : [{}]", address, e.getMessage());
        return null;
    }
}