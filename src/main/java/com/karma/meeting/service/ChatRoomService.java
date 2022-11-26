package com.karma.meeting.service;

import com.karma.meeting.model.exception.CustomException;
import com.karma.meeting.model.enums.CustomErrorCode;
import com.karma.meeting.model.entity.ChatRoom;
import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.model.dto.MessageDto;
import com.karma.meeting.repository.ChatRoomRepository;
import com.karma.meeting.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@RequestMapping("/api/chatRoom")
public class ChatRoomService {
    private final UserAccountRepository userAccountRepository;
    private final ChatRoomRepository chatRoomRepository;

    // C : 채팅방 만들기
    public Long createChatRoom(String title, String username){
        UserAccount userAccount = findUserByUsernameOrElseThrow(username);
        ChatRoom chatRoom = ChatRoom.of(title, userAccount);
        return chatRoomRepository.save(chatRoom).getId();
    }

    // R : 채팅방 메세지 가져오기
    public Set<MessageDto> getAllMessages(Long roomId){
        return chatRoomRepository.getReferenceById(roomId).getMessages().stream().map(MessageDto::from).collect(Collectors.toSet());
    }

    // U : 채팅방 제목 변경하기
    public void changeChatRoomTitle(Long roomId, String newTitle, String username){
        ChatRoom c = chatRoomRepository.getReferenceById(roomId);
        if (!c.getHost().equals(username)) {
            throw new CustomException(
                    CustomErrorCode.ENTITY_NOT_FOUNDED,
                    String.format("호스트인 [%s]만 채팅방 제목 변경가능...", c.getHost()));
        }
        c.setTitle(newTitle);
        chatRoomRepository.save(c);
    }

    // 채팅방 삭제
    public void deleteChatRoom(Long roomId){
        chatRoomRepository.deleteById(roomId);
    }

    private UserAccount findUserByUsernameOrElseThrow(String username){
        return userAccountRepository.findByUsername(username)
                .orElseThrow(()->{throw new CustomException(
                        CustomErrorCode.ENTITY_NOT_FOUNDED,
                        String.format("[%s]은 존재하지 않는 유저명...", username)
                );});
    }
}
