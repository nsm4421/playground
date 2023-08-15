package com.karma.community.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.karma.community.exception.CustomError;
import com.karma.community.exception.CustomErrorCode;
import com.karma.community.model.dto.UserAccountDto;
import com.karma.community.model.entity.UserAccount;
import com.karma.community.model.security.KakaoAccessTokenResponse;
import com.karma.community.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class UserAccountService {

    private final UserAccountRepository userAccountRepository;
    private final PasswordEncoder passwordEncoder;
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    //    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private final String kakaoOauth2ClinetId = "b6023639a0983010fa1b4636be190b80";
    //    @Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
    private final String redirectionUrl = "http://localhost:3000/oauth2/kakao";
    //    @Value("${spring.security.oauth2.client.provider.kakao.token-uri}")
    private final String tokenUri = "https://kauth.kakao.com/oauth/token";
    //    @Value("{spring.security.oauth2.client.provider.kakao.user-info-uri}")
    private final String userInfoUri = "https://kapi.kakao.com/v2/user/me";

    private Boolean isDuplicated(FieldsToCheckDuplicatedOrNot f, String value){
        return switch (f){
            case USERNAME -> userAccountRepository.countDuplicatedUsername(value)>0;
            case NICKNAME -> userAccountRepository.countDuplicatedNickname(value)>0;
            case EMAIL -> userAccountRepository.countDuplicatedEmail(value)>0;
        };
    }

    private void throwIfDuplicated(FieldsToCheckDuplicatedOrNot f, String value){
        boolean isDuplicated = isDuplicated(f, value);
        if (!isDuplicated)return;
        String message = switch (f){
            case USERNAME -> String.format("[%s]는 이미 존재하는 유저명입니다",value);
            case NICKNAME -> String.format("[%s]는 이미 존재하는 닉네임입니다",value);
            case EMAIL -> String.format("[%s]는 이미 존재하는 이메일입니다",value);
        };
        throw CustomError.of(CustomErrorCode.DUPLICATED_USER_INFO, message);
    }

    @Transactional(readOnly = true)
    public Optional<UserAccountDto> findByUsername(String username) {
        return userAccountRepository.findByUsername(username)
                .map(UserAccountDto::from);
    }

    @Transactional
    public UserAccountDto register(
            String username,
            String password,
            String email,
            String nickname,
            String description
    ) {
        // 중복체크
        throwIfDuplicated(FieldsToCheckDuplicatedOrNot.USERNAME, username);
        throwIfDuplicated(FieldsToCheckDuplicatedOrNot.NICKNAME, nickname);
        throwIfDuplicated(FieldsToCheckDuplicatedOrNot.EMAIL, email);
        // DB에 저장
        return UserAccountDto.from(
                userAccountRepository.save(UserAccount.of(
                        username,
                        passwordEncoder.encode(password),    // 암호화된 비밀번호를 DB에 저장
                        email,
                        nickname,
                        description,
                        LocalDateTime.now(),                 // createdAt, modifiedAt
                        username                             // createdBy, modifiedBy
                ))
        );
    }

    /**
     * Auth 토큰을 받아서, Access 토큰을 return
     * @param authToken 인증토큰
     * @return AccessToken
     */
    public KakaoAccessTokenResponse getAccessTokenByAuthToken(String authToken) {

        /**
         * Request
         * request path : https://kauth.kakao.com/oauth/token (application.yaml에서 token-uri로 정의한 주소)
         * grant_type : authorization_code
         * client_id : kakao 개발자 사이트에서 발급받은 client id (application.yaml파일에 있는 client id와 동일)
         * redirect_uri : kakao 개발자 사이트에서 설정한 redirect uri (application.yaml파일에 있는 경로와 동일)
         * code : Front-End로 부터 받은 인증토큰
         */
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", kakaoOauth2ClinetId);
        params.add("redirect_uri", redirectionUrl);
        params.add("code", authToken);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(tokenUri, request, String.class);
            /**
             * Response
             * access_token
             * refresh_token
             * scope
             * token_type
             */
            return objectMapper.readValue(response.getBody(), KakaoAccessTokenResponse.class);
        } catch (RestClientException | JsonProcessingException ex) {
            ex.printStackTrace();
            System.out.println("ERRROR");
            throw CustomError.of(CustomErrorCode.KAKAO_OAUTH_FAIL);
        }
    }

    /**
     * Access Token을 받아서 유저 정보를 반환
     * @param accessToken
     * @return 유저정보
     */
    public String getUserInfoByAccessToken(String accessToken) {
        /**
         * Request
         * request path : https://kapi.kakao.com/v2/user/me (application.yaml에서 user-info-uri로 정의한 주소)
         * 인증토크을 Header에 실어서 보냄
         */
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(userInfoUri, request, String.class);
            return response.getBody();
        }catch (RestClientException ex) {
            ex.printStackTrace();
            throw CustomError.of(CustomErrorCode.KAKAO_OAUTH_FAIL);
        }
    }

    public UserAccountDto kakaoRegister(String username, String email, String nickname){
        // OAuth에서는 password가 필요하지 않으나, UserAccount에서 password필드가 Not Null로 설정되어있어, 임의로 값을 넣어줌
        String passwordToSave = passwordEncoder.encode("{bcrypt}KAKAO_SOCIAL_LOGIN_Password");
        // 이메일이 중복된 경우, null값 저장
        String emailToSave = isDuplicated(FieldsToCheckDuplicatedOrNot.EMAIL, email)?null:email;
        // 카카오 계정의 닉네임이 이미 존재하는 닉네임과 겹치는 경우 → 닉네임 앞에 KAKAO 붙여서 임시 닉네임으로 저장하기
        String nicknameToSave =isDuplicated(FieldsToCheckDuplicatedOrNot.NICKNAME, nickname)?String.format("KAKAO_%s", nickname):nickname;
        // DB 저장
        return register(username,passwordToSave, emailToSave, nicknameToSave, null);
    }

    /**
     * 유저계정 테이블에서 중복체크를 할 필드
     */
    private enum FieldsToCheckDuplicatedOrNot {
        USERNAME, NICKNAME, EMAIL;
    }
}
