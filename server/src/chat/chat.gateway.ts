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

interface JoinChatProps {
  uid: string;
  chatId: string;
}

interface SendMessageProps {
  chatId: string;
  message: string;
}

const port = Number(process.env.CHAT_PORT) || 3001;

// TODO : 인증기능 검사
@WebSocketGateway(port, { cors: true })
export class ChatGateWay implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer() server: Server;

  async handleConnection(client: Socket, ...args: any[]) {
    console.debug('new user connected', client.id);
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
  handleSendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId, message }: SendMessageProps,
  ) {
    console.debug(`chat-id:${chatId}|message:${message}`);
    const isIn = client.rooms.has(chatId);
    if (!isIn) {
      throw new BadRequestException('not in this chat room');
    }
    // TODO : sender
    this.server
      .to(chatId)
      .emit('receive-message', { sender: 'test', chatId, message });
  }
}
