package com.sns.karma.service;

import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCode;
import com.sns.karma.model.post.Post;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.post.SearchType;
import com.sns.karma.model.user.UserEntity;
import com.sns.karma.repository.PostEntityRepository;
import com.sns.karma.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PostService {

    private final UserEntityRepository userEntityRepository;
    private final PostEntityRepository postEntityRepository;

    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;

    // 게시글 작성
    public Post writePost(String title, String body, String author){
        // 존재하는 유저명인지 확인
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(author);
        // post entity 생성
        PostEntity postEntity = PostEntity.of(title, body, userEntity);
        // 저장
        return Post.fromEntity(postEntityRepository.save(postEntity));
    }

    // 게시글 수정
    public Post modifyPost(String title, String body, String author, Long postId){
        // 존재하는 유저명인지 확인
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(author);
        // 존재하는 포스팅인지 확인
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
        // 로그인한 유저와 포스팅을 작성한 유저가 동일한지 확인
        if (!postEntity.getUser().equals(userEntity)){
            throw new CustomException(ErrorCode.PERMISSION_DENIED, null);
        }
        // post entity 수정
        postEntity.setTitle(title);
        postEntity.setBody(body);
        // 저장
        return Post.fromEntity(postEntityRepository.saveAndFlush(postEntity));
    };

    // 게시글 삭제
    public void deletePost(String author, Long postId){
        // 존재하는 유저명인지 확인
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(author);
        // 존재하는 포스팅인지 확인
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
        // 로그인한 유저와 포스팅을 작성한 유저가 동일한지 확인
        if (!postEntity.getUser().equals(userEntity)){
            throw new CustomException(ErrorCode.PERMISSION_DENIED, null);
        }
        // 삭제
        postEntityRepository.delete(postEntity);
    }

    // 전체 게시글 목록
    public Page<Post> getAllPost(Pageable pageable){
        return postEntityRepository.findAll(pageable).map(Post::fromEntity);
    }

    // 검색된 게시글 목록
    public Page<Post> getSearchedPost(Pageable pageable, SearchType searchType, String keyword){
        if (keyword == null || keyword.isBlank()){
            return getAllPost(pageable);
        }
        switch (searchType){
            case TITLE:
                postEntityRepository.findByTitleContaining(keyword, pageable);
            case AUTHOR:
                UserEntity userEntity = ifExistUserNameThenUserEntityElseError(keyword);
                postEntityRepository.findAllByUser(userEntity, pageable);
            default:
                throw new CustomException(ErrorCode.INVALID_KEYWORD, null);
        }
    }

    // 특정 유저의 게시글 목록
    public Page<Post> getUsersPost(Pageable pageable, String username){
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(username);
        return postEntityRepository.findAllByUser(userEntity, pageable).map(Post::fromEntity);
    }

    private UserEntity ifExistUserNameThenUserEntityElseError(String username){
        return userEntityRepository.findByUserName(username)
                .orElseThrow(()->new CustomException(ErrorCode.USER_NOT_FOUND, null));
    }
    private PostEntity ifExistPostIdThenPostEntityElseError(Long postId){
        return postEntityRepository.findById(postId)
                .orElseThrow(()->new CustomException(ErrorCode.POST_NOT_FOUND, null));
    }
}