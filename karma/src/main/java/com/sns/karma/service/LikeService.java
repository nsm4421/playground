package com.sns.karma.service;

import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCode;
import com.sns.karma.model.like.LikeEntity;
import com.sns.karma.model.post.Post;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.UserEntity;
import com.sns.karma.repository.LikeEntityRepository;
import com.sns.karma.repository.PostEntityRepository;
import com.sns.karma.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LikeService {

    private final UserEntityRepository userEntityRepository;
    private final PostEntityRepository postEntityRepository;
    private final LikeEntityRepository likeEntityRepository;

    // 좋아요
    @Transactional
    public void addLike(Long postId, String username) {
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(username);
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
        LikeEntity likeEntity = ifExistLikeEntityElseError(userEntity, postEntity);
        likeEntityRepository.save(likeEntity);
    }

    // 좋아요 개수
    @Transactional
    public Long getLikeNum(Long postId) {
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
       return likeEntityRepository.countByPost(postEntity);
    }

    // 존재하는 유저명인지 확인
    private UserEntity ifExistUserNameThenUserEntityElseError(String username){
        return userEntityRepository.findByUserName(username)
                .orElseThrow(()->new CustomException(ErrorCode.USER_NOT_FOUND, null));
    }
    // 존재하는 포스팅인지 확인
    private PostEntity ifExistPostIdThenPostEntityElseError(Long postId){
        return postEntityRepository.findById(postId)
                .orElseThrow(()->new CustomException(ErrorCode.POST_NOT_FOUND, null));
    }
    // 이미 좋아요를 눌렀는지 확인
    private LikeEntity ifExistLikeEntityElseError(UserEntity userEntity, PostEntity postEntity){
        return likeEntityRepository.findByUserAndPost(userEntity, postEntity)
                .orElseThrow(()->new CustomException(ErrorCode.POST_NOT_FOUND, null));
    }
}