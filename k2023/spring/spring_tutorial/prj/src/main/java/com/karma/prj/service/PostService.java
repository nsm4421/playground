package com.karma.prj.service;

import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.exception.CustomException;
import com.karma.prj.model.dto.CommentDto;
import com.karma.prj.model.dto.PostDto;
import com.karma.prj.model.entity.*;
import com.karma.prj.model.util.*;
import com.karma.prj.repository.*;
import com.karma.prj.util.HashtagParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class PostService {
    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    private final EmotionRepository emotionRepository;
    private final NotificationRepository notificationRepository;
    private final NotificationService notificationService;
    private final HashtagParser hashtagParser;

    /**
     * 포스트 작성요청
     * @param title : 제목
     * @param content : 본문
     * @param user : 로그인한 유저
     * @param hashtags : 해쉬태그
     * @return 저장된 post id
     */
    @Transactional
    public Long createPost(String title, String content, UserEntity user, String hashtags){
        return postRepository.save(PostEntity.of(title, content, user, hashtagParser.stringToSet(hashtags))).getId();
    }

    /**
     * 포스트 단건조회
     * @param postId 조회할 포스트 id
     * @return PostDto
     */
    @Transactional(readOnly = true)
    public PostDto getPost(Long postId){
        return PostEntity.dto(findByPostIdOrElseThrow(postId));
    }

    /**
     * 포스팅 검색
     * @param pageable 
     * @param searchType : 검색타입 - none, title, hashtag, content, user
     * @param searchValue : 검색어
     * @return Page<PostDto>
     */
    @Transactional(readOnly = true)
    public Page<PostDto> getPostBySearch(Pageable pageable, SearchType searchType, String searchValue){
         Page<PostEntity> searched = switch (searchType){
            case NICKNAME -> postRepository.findAllByUser(pageable, findByNicknameOrElseThrow(searchValue));
            case TITLE -> postRepository.findAllByTitleContaining(pageable, searchValue);
            case HASHTAG -> postRepository.findAllByHashtags(pageable, searchValue);
            case CONTENT -> postRepository.findAllByContentContaining(pageable, searchValue);
            case NONE -> postRepository.findAll(pageable);
        };
        return searched.map(PostEntity::dto);
    }

    /**
     * 내가 작성한 포스팅
     * @return Page<PostDto>
     */
    @Transactional(readOnly = true)
    public Page<PostDto> getMyPosts(Pageable pageable, UserEntity user){
        return postRepository.findAllByUser(pageable, user).map(PostEntity::dto);
    }

    /**
     * 포스트 수정요청
     * @param postId 수정요청한 포스트 id
     * @param title 제목
     * @param content 본문
     * @param user 로그인한 유저
     */
    @Transactional
    public void modifyPost(Long postId, String title, String content, UserEntity user, String hashtags){
        PostEntity post = findByPostIdOrElseThrow(postId);
        if (!post.getUser().getUsername().equals(user.getUsername())){
            // 포스트 작성자와 수정 요청한 사람이 일치하는지 확인
            throw CustomException.of(CustomErrorCode.NOT_GRANTED_ACCESS);
        }
        post.setTitle(title);
        post.setContent(content);
        post.setHashtags(hashtagParser.stringToSet(hashtags));
        postRepository.save(post);
    }

    /**
     * 포스트 삭제요청 - 포스팅, 댓글, 좋아요, 알림 삭제
     * @param postId 삭제요청한 포스트 id
     * @param userId 로그인한 유저 id
     */
    @Transactional
    public void deletePost(Long postId, Long userId){
        PostEntity post = findByPostIdOrElseThrow(postId);
        if (!post.getUser().getId().equals(userId)){
            // 포스트 작성자와 삭제 요청한 사람이 일치하는지 확인
            throw CustomException.of(CustomErrorCode.NOT_GRANTED_ACCESS);
        }
        postRepository.deleteById(post.getId());
        commentRepository.deleteAllByPost(post);
        emotionRepository.deleteAllByPost(post);
        notificationRepository.deleteAllByPost(post);
    }

    /**
     * 댓글 조회
     * @param pageable
     * @param postId
     * @return 댓글 Dto Page
     */
    @Transactional(readOnly = true)
    public Page<CommentDto> getComments(Long postId, Pageable pageable){
        PostEntity post = findByPostIdOrElseThrow(postId);
        return commentRepository.findAllByPost(post, pageable).map(CommentEntity::dto);
    }

    /**
     * 댓글작성
     * @return Comment Dto
     */
    @Transactional
    public void createComment(Long postId, String content, UserEntity user){
        PostEntity post = findByPostIdOrElseThrow(postId);
        UserEntity author = post.getUser();                     // user : 댓쓴이 / author : 글쓴이
        CommentDto commentDto = CommentEntity.dto(commentRepository.save(CommentEntity.of(content, user, post)));   // 댓글작성
        // 알림생성
        NotificationEntity notification = notificationRepository.save(
                NotificationEntity.of(author, post, NotificationType.NEW_COMMENT_ON_POST,
                String.format("%s님이 댓글을 달았습니다", user.getNickname())));
        // 알림전송
        notificationService.sendNotification(NotificationEvent.from(notification));
    }

    /**
     * 댓글 수정
     */
    @Transactional
    public CommentDto modifyComment(Long postId, Long commentId, String content, UserEntity user){
        findByPostIdOrElseThrow(postId);
        CommentEntity comment = findByCommentIdOrElseThrow(commentId);
        if (!comment.getUser().getId().equals(user.getId())){
            throw CustomException.of(CustomErrorCode.NOT_GRANTED_ACCESS);
        }
        comment.setContent(content);
        return CommentEntity.dto(commentRepository.save(comment));
    }

    /**
     * 댓글 삭제
     */
    @Transactional
    public void deleteComment(Long postId, Long commentId, UserEntity user){
        findByPostIdOrElseThrow(postId);
        CommentEntity comment = findByCommentIdOrElseThrow(commentId);
        if (!comment.getUser().getId().equals(user.getId())){
            throw CustomException.of(CustomErrorCode.NOT_GRANTED_ACCESS);
        }
        commentRepository.deleteById(commentId);
    }

    /**
     * 좋아요 & 싫어요 개수, 포스팅 좋아요 & 싫어요 여부
     * @param postId 좋아요 & 싫어요 포스트 id
     */
    @Transactional(readOnly = true)
    public Map<String, Object> getEmotionInfo(UserEntity user, Long postId){
        PostEntity post = findByPostIdOrElseThrow(postId);
        EmotionEntity like = emotionRepository.findByUserAndPost(user, post).orElse(EmotionEntity.of(user, post, EmotionType.NONE));
        return Map.of(
                "LIKE", emotionRepository.countByPostAndEmotionType(post, EmotionType.LIKE),
                "HATE", emotionRepository.countByPostAndEmotionType(post, EmotionType.HATE),
                "EMOTION", like.getEmotionType()
        );
    }

    /**
     * 좋아요 & 싫어요 요청
     * @param postId 좋아요 & 싫어요 포스트 id
     * @param emotionType LIKE(좋아요), HATE(싫어요)
     * @param user like 누른사람
     */
    @Transactional
    public void handleEmotion(UserEntity user, Long postId, EmotionType emotionType, EmotionActionType emotionActionType){
        PostEntity post = findByPostIdOrElseThrow(postId);
        switch (emotionActionType){
            case NEW -> {
                emotionRepository.findByUserAndPost(user, post).ifPresent(it->{
                    throw CustomException.of(CustomErrorCode.ALREADY_LIKED);
                });
                emotionRepository.save(EmotionEntity.of(user, post, emotionType));
                UserEntity author = post.getUser();                     // 글쓴이
                // 알림 저장
                String message = String.format("[%s]님이 게시글 [%s]에 %s를 눌렀습니다", user.getNickname(), post.getTitle() , emotionType == EmotionType.LIKE?"좋아요":"싫어요");
                NotificationEntity notification = notificationRepository.save(NotificationEntity.of(author, post, NotificationType.NEW_LIKE_ON_POST, message));
                // 알림 보내기
                notificationService.sendNotification(NotificationEvent.from(notification));
            }
            case SWITCH -> {
                emotionRepository
                    .findByUserAndPostAndEmotionType(user, post, emotionType.getOpposite())
                    .ifPresent(it ->{
                        it.setEmotionType(emotionType);
                        emotionRepository.save(it);
                    });
            }
            case CANCEL -> {
                emotionRepository.findByUserAndPost(user, post).ifPresent(it->{
                    emotionRepository.deleteById(it.getId());
                });
            }
        }
    }

    @Transactional(readOnly = true)
    private UserEntity findByNicknameOrElseThrow(String nickname){
        return userRepository.findByNickname(nickname).orElseThrow(()->{
            throw CustomException.of(CustomErrorCode.USERNAME_NOT_FOUND);
        });
    }

    @Transactional(readOnly = true)
    private PostEntity findByPostIdOrElseThrow(Long postId){
        return postRepository.findById(postId).orElseThrow(()->{
            throw CustomException.of(CustomErrorCode.POST_NOT_FOUND);
        });
    }

    @Transactional(readOnly = true)
    private CommentEntity findByCommentIdOrElseThrow(Long commentId){
        return commentRepository.findById(commentId).orElseThrow(()->{
            throw CustomException.of(CustomErrorCode.COMMENT_NOT_FOUND);
        });
    }
}