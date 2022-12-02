package com.karma.meeting.controller;

import com.karma.meeting.controller.request.ChangeChatRoomTitleRequest;
import com.karma.meeting.controller.request.CreateChatroomRequest;
import com.karma.meeting.controller.response.GetChatRoomsResponse;
import com.karma.meeting.controller.response.Response;
import com.karma.meeting.model.CustomPrincipal;
import com.karma.meeting.service.ChatRoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/chat-room")
public class ChatRoomController {
    private final ChatRoomService chatRoomService;

    @PostMapping("/create")
    private Response<Long> createChatRoom(CreateChatroomRequest req, @AuthenticationPrincipal CustomPrincipal principal){
        /**
         * 채팅방 개설
         * Input : 채팅방 제목, Host 유저명
         * Output : 채팅방 id
         */
        Long chatRoomId = chatRoomService.createChatRoom(req.getTitle(), principal.getUsername());
        return Response.success(chatRoomId);
    }
    @GetMapping("/")
    private Page<GetChatRoomsResponse> getAllRoom(Pageable pageable){
        /**
         * 채팅방 목록 가져오기
         */
        return chatRoomService.getChatRooms(pageable).map(GetChatRoomsResponse::from);
    }

    @DeleteMapping("/{roomId}")
    private void deleteChatRoom(@PathVariable Long roomId){
        /**
         * 채팅방 삭제하기
         * Input : 채팅방 id
         */
        chatRoomService.deleteChatRoom(roomId);
    }

    @PutMapping("/{roomId}")
    private Response<String> changeChatRoomTitle(
            @PathVariable Long roomId,
            ChangeChatRoomTitleRequest req,
            @AuthenticationPrincipal CustomPrincipal principal
    ){
        /**
         * 채팅방 제목 변경하기
         * Input : 채팅방 id, principal
         * Output : 변경된 채팅방명
         */
        chatRoomService.changeChatRoomTitle(roomId, req.getTitle(), principal.getUsername());
        return Response.success(req.getTitle());
    }
}
