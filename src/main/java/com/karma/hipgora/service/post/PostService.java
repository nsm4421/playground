package com.karma.hipgora.service.post;

import com.karma.hipgora.exception.ErrorCode;
import com.karma.hipgora.exception.MyException;
import com.karma.hipgora.model.post.Post;
import com.karma.hipgora.model.post.PostEntity;
import com.karma.hipgora.model.user.UserEntity;
import com.karma.hipgora.repository.PostEntityRepository;
import com.karma.hipgora.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
@RequiredArgsConstructor
public class PostService {

    private final UserEntityRepository userEntityRepository;
    private final PostEntityRepository postEntityRepository;

    public Page<Post> getAllPost(Pageable pageable){
        return postEntityRepository.findAll(pageable).map(Post::from);
    }

    public Page<Post> getAllMyPost(Pageable pageable, String username){
        Long userId = findByUsernameOrElseThrowError(username).getId();
        return postEntityRepository.findAllByUserId(userId, pageable).map(Post::from);
    }

    public void writePost(String title, String body, Set<String> hashtags, String username){
        UserEntity userEntity = findByUsernameOrElseThrowError(username);
        PostEntity postEntity = PostEntity.of(title, body, userEntity, hashtags);
        postEntityRepository.save(postEntity);
    }
    public void modifyPost(Long postId, String title, String body, Set<String> hashtags, String username){
        findByUsernameOrElseThrowError(username);
        PostEntity postEntity = findByPostIdOrElseThrowError(postId);
        String author = postEntity.getUserEntity().getUsername();
        if (!username.equals(author)){  // 자기가 작성한 포스팅만 수정 가능
            throw new MyException(ErrorCode.INVALID_USER, null);
        }
        postEntity.setTitle(title);
        postEntity.setBody(body);
        postEntity.setHashtags(hashtags);
        postEntityRepository.saveAndFlush(postEntity);
    }

    public void deletePost(Long postId, String username){
        findByUsernameOrElseThrowError(username);
        PostEntity postEntity = findByPostIdOrElseThrowError(postId);
        String author = postEntity.getUserEntity().getUsername();
        if (!username.equals(author)){  // 자기가 작성한 포스팅만 삭제 가능
            throw new MyException(ErrorCode.INVALID_USER, null);
        }
        postEntityRepository.delete(postEntity);
    }

    private UserEntity findByUsernameOrElseThrowError(String username){
        return userEntityRepository
                .findByUsername(username)
                .orElseThrow(()->new MyException(ErrorCode.USER_NOT_FOUND, null));
    }

    private PostEntity findByPostIdOrElseThrowError(Long postId){
        return postEntityRepository
                .findById(postId)
                .orElseThrow(()->new MyException(ErrorCode.POST_NOT_FOUND, null));
    }
}
