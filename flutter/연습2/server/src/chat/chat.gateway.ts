import { BadRequestException, NotFoundException } from '@nestjs/common';
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
import { GroupChatService } from './group_chat.service';
import { AuthService } from 'src/auth/auth.service';
import { PrivateChatService } from './private_chat.service';

interface JoinGroupChatProps {
  chatId: string;
}

interface SendGroupMessageProps {
  chatId: string;
  content: string;
}

interface SendPrivateMessageProps {
  receiverId: string;
  content: string;
}

interface DeletePrivateChatMessageProps {
  messageId: number;
}

const port = Number(process.env.CHAT_PORT) || 3001;

enum EventNames {
  // group chat
  joinGroupChat = 'join-group-chat',
  leaveGroupChat = 'leave-group-chat',
  sendGroupChatMessage = 'send-group-chat-message',
  // private chat
  joinPrivateChat = 'join-private-chat',
  leavePrivateChat = 'leave-private-chat',
  sendPrivateChatMessage = 'send-private-chat-message',
  receivePrivateChatMessage = 'receive-private-chat-message',
  deletePrivatChatMessage = 'delete-private-chat-message',
  // etc
  newUser = 'new-user',
  userLeave = 'user-leave',
}

@WebSocketGateway(port, { cors: true })
export class ChatGateWay implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer() server: Server;

  constructor(
    private readonly authService: AuthService,
    private readonly groupChatService: GroupChatService,
    private readonly privateChatService: PrivateChatService,
  ) {}

  /**
   * Header로부터 Token을 받아와서 인증정보를 반환
   * @param client
   * @returns auth
   */
  private async getAuthFromHeader(client: Socket) {
    const token = client.handshake.headers['authorization'];
    const auth = await this.authService.decodeToken(token);
    if (!auth) {
      client.disconnect();
      console.debug('connection failed since token is not valid');
      return;
    }
    return auth;
  }

  async handleConnection(client: Socket) {
    // 인증검사
    const auth = await this.getAuthFromHeader(client);
    console.debug(`socket connected|uid:${auth.sub}|clientId:${client.id}`);
    // 유저가 로그인한 경우, userId를 roomId로 입장시킴
    client.join(auth.sub);
  }

  async handleDisconnect(client: Socket) {
    console.debug('user disconnected', client.id);
    for (const roomId in client.rooms.keys) {
      client.leave(roomId);
    }
  }

  /// 단체방 입장하기
  @SubscribeMessage(EventNames.joinGroupChat)
  handleJoinGroupChat(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId }: JoinGroupChatProps,
  ) {
    console.debug(`${EventNames.joinGroupChat}|chat-id:${chatId}`);
    client.join(chatId);
    this.server.to(chatId).emit(EventNames.newUser, client.id);
  }

  /// 단체방 퇴장하기
  @SubscribeMessage(EventNames.leaveGroupChat)
  handleLeaveGroupChat(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId }: JoinGroupChatProps,
  ) {
    console.debug(`${EventNames.leaveGroupChat}|chat-id:${chatId}`);
    client.leave(chatId);
    this.server.to(chatId).emit(EventNames.userLeave, client.id);
  }

  /// 단체 메시지 보내기
  @SubscribeMessage(EventNames.sendGroupChatMessage)
  async handleSendGroupChatMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() { chatId, content }: SendGroupMessageProps,
  ) {
    console.debug(
      `send-group-chat-message|chat-id:${chatId}|content:${content}`,
    );
    try {
      // 현재 채팅방에 있는 유저인지 체크
      const isIn = client.rooms.has(chatId);
      if (!isIn) {
        throw new BadRequestException('not in this chat room');
      }

      // 유저 정보 조회
      const auth = await this.getAuthFromHeader(client);
      const user = await this.authService.get(auth.sub);

      // 채팅방에 메세지 저장
      const message = await this.groupChatService.createMessage({
        content,
        chatId,
        currentUid: user.id,
      });

      // 채팅방에 있는 유저들에게 메세지 정보 보내기
      const payload = {
        ...message,
        creator: {
          id: user.id,
          nickanme: user.nickname,
          profileImage: user.profileImage,
        },
      };
      this.server
        .to(chatId)
        .emit(EventNames.receivePrivateChatMessage, payload);
    } catch (error) {
      console.error(error);
    }
  }

  /// DM 보내기
  @SubscribeMessage(EventNames.sendPrivateChatMessage)
  async handleSendPrivateChatMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody()
    { content, receiverId }: SendPrivateMessageProps,
  ) {
    console.debug(`send-private-chat-message|content:${content}`);
    try {
      // 유저 정보 조회
      const auth = await this.getAuthFromHeader(client);
      const user = await this.authService.get(auth.sub);

      // 현재 채팅방에 넣기
      if (!client.rooms.has(user.id)) {
        client.join(user.id);
      }

      // 채팅방에 메세지 저장
      let message = await this.privateChatService.createChatMessage({
        senderId: user.id,
        receiverId,
        content,
      });

      // 메시지 조회
      message = await this.privateChatService.findMessageById({
        messageId: message.id,
        currentUid: user.id,
      });

      // 메세지 알리기
      console.debug(
        `${EventNames.receivePrivateChatMessage}|to ${receiverId} ${user.id}`,
      );
      this.server
        .to([receiverId, user.id])
        .emit(EventNames.receivePrivateChatMessage, message);
    } catch (error) {
      console.error(error);
    }
  }

  /// DM 삭제하기
  @SubscribeMessage(EventNames.deletePrivatChatMessage)
  async deletePrivateMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody()
    { messageId }: DeletePrivateChatMessageProps,
  ) {
    console.debug(`${EventNames.deletePrivatChatMessage}|id:${messageId}`);
    try {
      // 유저 정보 조회
      const auth = await this.getAuthFromHeader(client);
      const user = await this.authService.get(auth.sub);

      // 메세지 조회
      const message = await this.privateChatService.findMessageById({
        messageId,
        currentUid: user.id,
      });
      if (!message) {
        throw new NotFoundException('message not found');
      } else if (message.sender.id !== user.id) {
        throw new BadRequestException('only sender can delete own message');
      }

      // 메세지 삭제
      await this.privateChatService.deleteChatMessage({
        currentUid: user.id,
        messageId,
      });

      // receiver에게 메세지가 삭제되었음 알리기
      this.server
        .to([message.receiver.id, user.id])
        .emit(EventNames.deletePrivatChatMessage, {
          ...message,
          deletedAt: Date.now().toLocaleString(),
        });
    } catch (error) {
      console.error(error);
    }
  }
}
