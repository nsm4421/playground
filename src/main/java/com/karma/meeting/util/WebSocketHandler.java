package com.karma.meeting.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.karma.meeting.model.dto.MessageDto;
import com.karma.meeting.model.enums.CustomErrorCode;
import com.karma.meeting.model.exception.CustomException;
import com.karma.meeting.repository.ChatRoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@RequiredArgsConstructor
@Component
public class WebSocketHandler extends TextWebSocketHandler {

    private final ConcurrentHashMap<Long, HashMap<String, WebSocketSession>> webSockets = new ConcurrentHashMap<Long, HashMap<String, WebSocketSession>>();
    private final ObjectMapper objectMapper;

    public void sendMessage(WebSocketSession session, MessageDto dto) throws Exception{
        try {
            this.handleTextMessage(session, new TextMessage(objectMapper.writeValueAsString(dto.toString())));
        } catch (IOException e){
           e.printStackTrace();
           log.error(String.format("Error occur on session | id: [%s] | message : [%s]", session.getId(), dto.getContent()));
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {

        super.handleTextMessage(session, textMessage);
        MessageDto dto = objectMapper.readValue(textMessage.getPayload(), MessageDto.class);
        Long roomId = dto.getRoomId();
        // map(webSockets)에 session 넣기/빼기
        switch (dto.getMessageType()) {
            case ENTER:
                webSockets.get(roomId).put(session.getId(), session);
            case COMM:
            case EXIT:
                webSockets.get(roomId).remove(session.getId());
        }
        // 메세지 보내기
        webSockets.get(roomId).entrySet().parallelStream().forEach((Map.Entry<String, WebSocketSession> args) ->{
            if (!args.getKey().equals(session.getId())){
                try{
                    args.getValue().sendMessage(textMessage);
                } catch (IOException e){
                    log.error(String.format("Error occurs on session [%s] \n %s", args.getKey(), e.getMessage()));
                    throw new CustomException(CustomErrorCode.INTERNAL_SERVER_ERROR, "채팅서버 에러 발생");
                }
            }
        });
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        try{
            log.info(String.format("Session [%s] connected", session.getId()));
        } catch (Exception e){
            log.error(String.format("Error occurs in session [%s]... \n %s", session.getId(), e.toString()));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        try{
            log.info(String.format("Session [%s] disconnected", session.getId()));
        } catch (Exception e){
            log.error(String.format("Error occurs in session [%s]... \n %s", session.getId(), e.toString()));
        }
    }
}
