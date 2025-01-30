import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { PrivateChatMessage } from './entity/private_chat_message.entity';

interface FetchChatsProps {
  currentUid: string;
}

interface FetchMessagesProps extends FetchChatsProps {
  opponentUid: string;
  lastMessageId?: number;
  page: number;
  pageSize?: number;
}

interface FindMessageProps {
  messageId: number;
  currentUid: string;
}

interface SendChatMeessageProps {
  senderId: string;
  receiverId: string;
  content: string;
}

interface DeleteChatMessageProps {
  currentUid: string;
  messageId: number;
}

@Injectable()
export class PrivateChatService {
  constructor(
    @InjectRepository(PrivateChatMessage)
    private readonly messageRepository: Repository<PrivateChatMessage>,
  ) {}

  /**
   * 가장 최신 메세지 목록 가져오기
   * @param currentUid 현재 로그인한 유저 아이디
   * @returns 대화 상대방별 가장 최신 메세지 목록
   */
  async fetchLastestMessages({ currentUid }: FetchChatsProps) {
    return this.messageRepository
      .createQueryBuilder('message')
      .select('DISTINCT ON (message.senderId, message.receiverId) message.*')
      .where('message.sender = :currentUid OR message.receiver = :currentUid', {
        currentUid,
      })
      .orderBy('message.senderId')
      .addOrderBy('message.receiverId')
      .addOrderBy('message.createdAt', 'DESC')
      .leftJoin('message.sender', 'sender')
      .addSelect(['sender.id', 'sender.nickname', 'sender.profileImage'])
      .leftJoin('message.receiver', 'receiver')
      .addSelect(['receiver.id', 'receiver.nickname', 'receiver.profileImage'])
      .getMany();
  }

  /**
   * 메세지 가져오기
   * @param currentUid 현재 로그인한 유저 아이디
   * @returns 대화 상대방별 가장 최신 메세지 목록
   */
  async fetchMessages({
    page,
    pageSize,
    currentUid,
    opponentUid,
    lastMessageId,
  }: FetchMessagesProps) {
    const [data, totalCount] = await this.messageRepository
      .createQueryBuilder('message')
      // 내가 보내거나 받은 메세지만
      .where(
        'message.senderId = :currentUid OR message.receiverId = :opponentUid',
        { currentUid, opponentUid },
      )
      .orWhere(
        'message.senderId = :opponentUid OR message.receiverId = :currentUid',
        { currentUid, opponentUid },
      )
      .andWhere(lastMessageId ? 'id < :lastMessageId' : '1=1', {
        lastMessageId,
      })
      .leftJoin('message.sender', 'sender')
      .addSelect(['sender.id', 'sender.nickname', 'sender.profileImage'])
      .leftJoin('message.receiver', 'receiver')
      .addSelect(['receiver.id', 'receiver.nickname', 'receiver.profileImage'])
      .skip((page - 1) * pageSize)
      .take(pageSize)
      .orderBy('message.createdAt', 'DESC')
      .getManyAndCount();
    return {
      data,
      totalCount,
      pageSize,
      currentPage: page,
      totalPages: Math.ceil(totalCount / pageSize),
    };
  }

  async createChatMessage({
    senderId,
    receiverId,
    content,
  }: SendChatMeessageProps) {
    // 메세지 저장
    const message = await this.messageRepository.save({
      sender: {
        id: senderId,
      },
      receiver: {
        id: receiverId,
      },
      content,
    });
    return message;
  }

  async findMessageById({ messageId, currentUid }: FindMessageProps) {
    const message = await this.messageRepository.findOne({
      where: { id: messageId },
      relations: ['sender', 'receiver'],
    });
    if (
      message.sender.id !== currentUid &&
      message.receiver.id !== currentUid
    ) {
      throw new BadRequestException('only sender and receiver can see message');
    }
    return message;
  }

  async deleteChatMessage({ currentUid, messageId }: DeleteChatMessageProps) {
    const message = await this.messageRepository.findOne({
      where: { id: messageId },
      relations: ['sender'],
    });
    if (message.sender.id !== currentUid) {
      throw new BadRequestException('only author can delete own chat message');
    }
    return await this.messageRepository.softDelete({ id: messageId });
  }
}
