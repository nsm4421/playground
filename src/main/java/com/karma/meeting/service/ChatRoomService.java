package com.karma.meeting.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.karma.meeting.model.dto.MessageDto;
import com.karma.meeting.model.enums.MessageType;
import com.karma.meeting.model.exception.CustomException;
import com.karma.meeting.model.enums.CustomErrorCode;
import com.karma.meeting.model.entity.ChatRoom;
import com.karma.meeting.model.entity.UserAccount;
import com.karma.meeting.repository.ChatRoomRepository;
import com.karma.meeting.repository.UserAccountRepository;
import com.karma.meeting.util.WebSocketHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.WebSocketSession;



@Service
@RequiredArgsConstructor
@RequestMapping("/api/chatRoom")
public class ChatRoomService {
    private final UserAccountRepository userAccountRepository;
    private final ChatRoomRepository chatRoomRepository;

    // 채팅 보내기

    public Long createChatRoom(String title, String username){
        /**
         * 채팅방 만들기
         */
        UserAccount userAccount = findUserByUsernameOrElseThrow(username);
        ChatRoom chatRoom = ChatRoom.of(title, userAccount);
        return chatRoomRepository.save(chatRoom).getId();
    }

    public Page<ChatRoom> getChatRooms(Pageable pageable){
        /**
         * 채팅방 목록 가져오기
         */
        return chatRoomRepository.findAll(pageable);
    }

    public void changeChatRoomTitle(Long roomId, String newTitle, String username){
        /**
         *  채팅방 제목 변경하기
         */
        ChatRoom c = chatRoomRepository.getReferenceById(roomId);
        if (!c.getHost().equals(username)) {
            throw new CustomException(
                    CustomErrorCode.ENTITY_NOT_FOUNDED,
                    String.format("호스트인 [%s]만 채팅방 제목 변경가능...", c.getHost()));
        }
        c.setTitle(newTitle);
        chatRoomRepository.save(c);
    }

    public void deleteChatRoom(Long roomId){
        /**
         *  채팅방 삭제
         */
        chatRoomRepository.deleteById(roomId);
    }

    private UserAccount findUserByUsernameOrElseThrow(String username){
        /**
         *  존재하는 유저명인지 확인
         */
        return userAccountRepository.findByUsername(username)
                .orElseThrow(()->{throw new CustomException(
                        CustomErrorCode.ENTITY_NOT_FOUNDED,
                        String.format("[%s]은 존재하지 않는 유저명...", username)
                );});
    }
}
