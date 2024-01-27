package com.karma.community.model.security;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("Kakao OAuth2 Test")
class KakaoUserInfoResponseTest {
    private final ObjectMapper mapper = new ObjectMapper();

    @DisplayName("get auth result, then return kakao auth object")
    @Test
    void givenMapFromJson_whenInstantiating_thenReturnsKakaoResponseObject() throws Exception {
        // Given
        String serializedResponse = """
                {
                    "id": 1234567890,
                    "connected_at": "2022-01-02T00:12:34Z",
                    "properties": {
                        "nickname": "홍길동"
                    },
                    "kakao_account": {
                        "profile_nickname_needs_agreement": false,
                        "profile": {
                            "nickname": "홍길동"
                        },
                        "has_email": true,
                        "email_needs_agreement": false,
                        "is_email_valid": true,
                        "is_email_verified": true,
                        "email": "test@gmail.com"
                    }
                }
                """;
        Map<String, Object> attributes = mapper.readValue(serializedResponse, new TypeReference<>() {});

        // When
        KakaoUserInfoResponse result = KakaoUserInfoResponse.from(attributes);

        // Then
        assertThat(result)
                .hasFieldOrPropertyWithValue("id", 1234567890L)
                .hasFieldOrPropertyWithValue("connectedAt", ZonedDateTime.of(2022, 1, 2, 0, 12, 34, 0, ZoneOffset.UTC)
                        .withZoneSameInstant(ZoneId.systemDefault())
                        .toLocalDateTime()
                )
                .hasFieldOrPropertyWithValue("kakaoAccount.profile.nickname", "홍길동")
                .hasFieldOrPropertyWithValue("kakaoAccount.email", "test@gmail.com");
    }

}