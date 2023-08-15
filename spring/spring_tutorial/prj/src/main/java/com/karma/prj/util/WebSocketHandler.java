package com.karma.prj.util;

import com.karma.prj.exception.CustomErrorCode;
import com.karma.prj.exception.CustomException;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.*;

@Component
@Log4j2
public class WebSocketHandler extends TextWebSocketHandler {

    private static Map<String, WebSocketSession> wsMap = Collections.synchronizedMap(Map.of());
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        wsMap.entrySet().parallelStream().map(entry->{
            try {
                entry.getValue().sendMessage(message);
                log.info("payload:{}", payload);
            } catch (IOException e) {
                throw CustomException.of(CustomErrorCode.CHATTING_SERVER_ERROR);
            }
            return null;
        });
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        wsMap.put(session.getId(), session);
        log.info("client {} is connected...", session.getId());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        wsMap.remove(session.getId());
        log.info("client {} is connected...", session.getId());
    }
}
