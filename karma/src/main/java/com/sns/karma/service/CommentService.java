package com.sns.karma.service;

import com.sns.karma.exception.CustomException;
import com.sns.karma.exception.ErrorCode;
import com.sns.karma.model.comment.Comment;
import com.sns.karma.model.comment.CommentEntity;
import com.sns.karma.model.post.PostEntity;
import com.sns.karma.model.user.UserEntity;
import com.sns.karma.repository.CommentEntityRepository;
import com.sns.karma.repository.LikeEntityRepository;
import com.sns.karma.repository.PostEntityRepository;
import com.sns.karma.repository.UserEntityRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class CommentService {

    private final UserEntityRepository userEntityRepository;
    private final PostEntityRepository postEntityRepository;
    private final LikeEntityRepository likeEntityRepository;
    private final CommentEntityRepository commentEntityRepository;

    // 댓글 조회
    @Transactional
    public Page<Comment> getComment(Long postId, Pageable pageable) {
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
        return commentEntityRepository.findAllByPost(postEntity, pageable).map(Comment::fromEntity);
    }

    // 댓글 조회
    @Transactional
    public void writeComment(Long postId, String username, String comment) {
        UserEntity userEntity = ifExistUserNameThenUserEntityElseError(username);
        PostEntity postEntity = ifExistPostIdThenPostEntityElseError(postId);
        CommentEntity commentEntity = CommentEntity.of(userEntity, postEntity, comment);
        commentEntityRepository.save(commentEntity);
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
