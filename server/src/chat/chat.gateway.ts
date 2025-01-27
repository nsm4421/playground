import { BadRequestException } from '@nestjs/common';
import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';

import { Server, Socket } from 'socket.io';
import { ChatService } from './chat.service';
import { AuthService } from 'src/auth/auth.service';

interface JoinChatProps {
  uid: string;
  chatId: string;
}

interface SendMessageProps {
  chatId: string;
  token: string;
  content: string;
}

const port = Number(process.env.CHAT_PORT) || 3001;

@WebSocketGateway(port, { cors: true })
export class ChatGateWay implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer() server: Server;

  constructor(
    private readonly authService: AuthService,
    private readonly chatService: ChatService,
  ) {}

  async handleConnection(client: Socket) {
    console.debug('user connected', client.id);
  }

  async handleDisconnect(client: Socket) {
    console.debug('user disconnected', client.id);
  }

  @SubscribeMessage('join-chat')
  handleJoin(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId }: JoinChatProps,
  ) {
    console.debug(`chat-id:${chatId}`);
    client.join(chatId);
    this.server.to(chatId).emit('new-user', client.id);
  }

  @SubscribeMessage('send-message')
  async handleSendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId, content, token }: SendMessageProps,
  ) {
    console.debug(`chat-id:${chatId}|content:${content}`);
    try {
      // 현재 채팅방에 있는 유저인지 체크
      const isIn = client.rooms.has(chatId);
      if (!isIn) {
        throw new BadRequestException('not in this chat room');
      }

      // 토큰으로 부터 유저 id, 유저명 가져오기
      const decoded = await this.authService.decodeToken(token);

      // 채팅방에 메세지 저장
      const message = await this.chatService.createMessage({
        content,
        chatId,
        currentUid: decoded.sub,
      });

      // 채팅방에 있는 유저들에게 메세지 정보 보내기
      this.server.to(chatId).emit('receive-message', {
        ...message,
        creator: { id: decoded.sub, username: decoded.username },
      });
    } catch (error) {
      console.error(error);
    }
  }
}
