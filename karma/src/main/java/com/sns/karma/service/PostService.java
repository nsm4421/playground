package com.sns.karma.service;

import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCode;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.Provider;
import com.sns.karma.model.user.User;
import com.sns.karma.model.user.UserEntity;
import com.sns.karma.repository.PostEntityRepository;
import com.sns.karma.repository.UserEntityRepository;
import com.sns.karma.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PostService {

    private final UserEntityRepository userEntityRepository;
    private final PostEntityRepository postEntityRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;  // password encoder

    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;

    // 게시글 작성
    public void writePost(String title, String body, String author){
        // 존재하는 유저명인지 확인
        UserEntity userEntity = userEntityRepository.findByUserName(author)
                .orElseThrow(()->new CustomException(ErrorCode.USER_NOT_FOUND, null));
        // post entity 생성
        PostEntity postEntity = PostEntity.of(title, body, userEntity);
        // 저장
        postEntityRepository.save(postEntity);
    }




}
