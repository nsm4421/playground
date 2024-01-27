package com.karma.prj.service;

import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.exception.CustomException;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.model.entity.FollowEntity;
import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.model.util.FollowingType;
import com.karma.prj.model.util.RoleType;
import com.karma.prj.repository.FollowRepository;
import com.karma.prj.repository.UserCacheRepository;
import com.karma.prj.repository.UserRepository;
import com.karma.prj.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final UserCacheRepository userCacheRepository;
    private final FollowRepository followRepository;
    @Value("${jwt.secret-key}") private String secretKey;
    @Value("${jwt.duration}") private Long duration;

    /**
     * 회원가입
     * @param email 이메일
     * @param username 유저명
     * @param nickname 닉네임
     * @param password 비밀번호
     * @return 회원가입 성공시 UserDto
     */
    @Transactional
    public UserDto register(String email, String username, String nickname, String password){
        // 중복체크
        checkDuplicated(_field.EMAIL, email);
        checkDuplicated(_field.NICKNAME, nickname);
        checkDuplicated(_field.USERNAME, username);
        // 비밀번호 인코딩
        String encodedPassword = bCryptPasswordEncoder.encode(password);
        return UserEntity.dto(userRepository.save(UserEntity.of(email, username, nickname, encodedPassword, RoleType.USER, null, null)));
    }

    /**
     * 로그인 & 캐싱
     * @param username 유저명
     * @param password 비밀번호
     * @return JWT 토큰값
     */
    @Transactional(readOnly = true)
    public String login(String username, String password){
        // 존재하는 회원여부
        UserEntity user = findByUsernameOrElseThrow(username);
        // 비밀번호 일치여부 확인
        if (!bCryptPasswordEncoder.matches(password, user.getPassword())){
            throw CustomException.of(CustomErrorCode.INVALID_PASSWORD);
        }
        // 캐싱
        userCacheRepository.setUserByUsername(user);
        // JWT 반환
        return JwtUtil.generateToken(username, secretKey, duration);
    }
    /**
     * 팔로우 기능
     * @param leaderNickname : 팔로우할 유저의 닉네임
     * @param follower : 팔로우 유저
     */
    @Transactional
    public void followUser(String leaderNickname, UserEntity follower){
        // 자기 자신을 팔로우 하는 경우 에러
        if (follower.getNickname().equals(leaderNickname)){
            throw CustomException.of(CustomErrorCode.INTERNAL_SERVER_ERROR, "leader and follower are same...?");
        }
        // 팔로잉 당하는 유저가 존재하는지 확인
        UserEntity leader = findByNicknameOrElseThrow(leaderNickname);
        // 이미 팔로우가 되어 있는지 확인
        followRepository.findByLeaderAndFollower(leader, follower).ifPresent(it->{
            throw CustomException.of(CustomErrorCode.ALREADY_FOLLOWING);
        });
        // 팔로우 관계 저장
        followRepository.save(FollowEntity.of(leader, follower));
    }
    /**
     * 특정 유저의 팔로잉 관계 조회하기
     * @param targetNickname : 특정 유저의 닉네임
     * @param followingType
     * - LEADER : 특정 유저를 팔로잉 하는 팔로워들
     * - FOLLOWER : 특정 유저가 팔로우하는 리더들
     * @return User Dto
     */
    @Transactional(readOnly = true)
    public Set<UserDto> getUsersFollow(String targetNickname, FollowingType followingType){
        if (followingType.equals(FollowingType.LEADER)){
            return followRepository.findByLeader_Nickname(targetNickname)
                    .stream().map(FollowEntity::getFollower).map(UserEntity::dto).collect(Collectors.toSet());
        }
        if (followingType.equals(FollowingType.FOLLOWER)){
            return followRepository.findByFollower_Nickname(targetNickname)
                    .stream().map(FollowEntity::getLeader).map(UserEntity::dto).collect(Collectors.toSet());
        }
        throw CustomException.of(CustomErrorCode.INTERNAL_SERVER_ERROR);
    }
    /**
     * 언팔로우 기능
     * @param leaderNickname : 팔로우된 사람의 닉네임
     * @param follower : 팔로워
     */
    @Transactional
    public void unFollow(String leaderNickname, UserEntity follower){
        // 자기 자신을 언팔 하는 경우 에러
        if (follower.getNickname().equals(leaderNickname)){
            throw CustomException.of(CustomErrorCode.INTERNAL_SERVER_ERROR, "leader and follower are same...?");
        }
        FollowEntity follow = followRepository
                .findByLeaderAndFollower(findByNicknameOrElseThrow(leaderNickname), follower)
                .orElseThrow(()->{throw CustomException.of(CustomErrorCode.FOLLOWING_NOT_FOUND);});
        followRepository.delete(follow);
    }
    /**
     * 중복체크
     * @param f 중복체크할 필드
     * @param value 중복체크할 값
     */
    @Transactional(readOnly = true)
    private void checkDuplicated(_field f, String value){
       switch (f){
           case EMAIL -> {
               // 중복체크 - 유저명, 닉네임, 이메일
               userRepository.findByUsername(value).ifPresent(it->{
                   throw CustomException.of(
                           CustomErrorCode.DUPLICATED_USERNAME,
                           String.format("Username [%s] is duplicated...", value)
                   );
               });
           }
           case USERNAME -> {
               userRepository.findByEmail(value).ifPresent(it->{
                   throw CustomException.of(
                           CustomErrorCode.DUPLICATED_USERNAME,
                           String.format("Email [%s] is duplicated...", value)
                   );
               });
           }
           case NICKNAME -> {
               userRepository.findByNickname(value).ifPresent(it->{
                   throw CustomException.of(
                           CustomErrorCode.DUPLICATED_NICKNAME,
                           String.format("Nickname [%s] is duplicated...", value)
                   );
               });
           }
       }
    }

    /**
     * 중복체크할 필드
     */
    private enum _field{
        USERNAME, NICKNAME, EMAIL;
    }

    @Transactional(readOnly = true)
    public UserEntity findByUsernameOrElseThrow(String username){
        // redis cache 조회 후 없으면
        return userCacheRepository.getUserByUsername(username).orElseGet(
                // DB 조회 후 없으면 에러
                ()-> userRepository.findByUsername(username).orElseThrow(
                        ()->{throw CustomException.of(CustomErrorCode.USERNAME_NOT_FOUND);})
        );
    }
    @Transactional(readOnly = true)
    public UserEntity findByNicknameOrElseThrow(String nickname){
        return userRepository.findByNickname(nickname).orElseThrow(()->{
            throw CustomException.of(CustomErrorCode.USER_NOT_FOUND);
        });
    }
}
