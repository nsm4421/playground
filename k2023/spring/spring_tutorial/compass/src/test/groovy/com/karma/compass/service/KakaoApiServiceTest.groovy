package com.karma.compass.service

import com.karma.compass.AbstractIntegrationBaseTest
import com.karma.compass.domain.dto.KakaoApiResponseDto
import com.karma.compass.util.KakaoApiService
import org.springframework.beans.factory.annotation.Autowired

import java.nio.charset.StandardCharsets

class KakaoApiServiceTest extends AbstractIntegrationBaseTest {

    @Autowired private KakaoApiService kakaoService

    def "buildUri"() {
        given:
            String 한글주소 = "서울 상도동"
            def charset = StandardCharsets.UTF_8

        when:
            def uri = kakaoService.buildUri(한글주소)
            def 인코딩 = uri.toString()
            def 디코딩 = URLDecoder.decode(인코딩, charset)

        then:
            디코딩 ==  "https://dapi.kakao.com/v2/local/search/address.json?query=" + 한글주소
    }

    def "searchAddress - if address is null, then return null"(){
        given:
        String 한글주소 = null
        when:
            KakaoApiResponseDto 검색결과 = kakaoService.searchAddress(한글주소)
        then:
            검색결과 == null
    }

    def "searchAddress - if address is valid, then return dto"(){
        given:
            String 한글주소 = "서울 동작구 상도동"
        when:
            KakaoApiResponseDto 검색결과 = kakaoService.searchAddress(한글주소)
        then:
            검색결과.documents.size()>0
            검색결과.meta.totalCount>0
    }
}