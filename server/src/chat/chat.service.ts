import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Chat } from './entity/chat.entity';
import { Message } from './entity/message.entity';

interface FetchChatsProps {
  page: number;
  pageSize?: number;
}

interface CreateChatProps {
  title: string;
  hashtags: string[];
  createdBy: string;
}

interface CreateMessageProps {
  content: string;
  chatId: string;
  createdBy: string;
}

@Injectable()
export class ChatService {
  constructor(
    @InjectRepository(Chat)
    private readonly chatRepository: Repository<Chat>,
    @InjectRepository(Message)
    private readonly messageRepository: Repository<Message>,
  ) {}

  async fetchChats({ page, pageSize }: FetchChatsProps) {
    const [data, totalCount] = await this.chatRepository
      .createQueryBuilder('chat')
      .leftJoinAndSelect('chat.creator', 'user')
      .select(['chat', 'user.id', 'user.username', 'user.profileImage'])
      .skip((page - 1) * pageSize)
      .take(pageSize)
      .orderBy('chat.updatedAt', 'DESC')
      .getManyAndCount();
    return {
      data,
      totalCount,
      pageSize,
      currentPage: page,
      totalPages: Math.ceil(totalCount / pageSize),
    };
  }

  async createChat({ title, hashtags, createdBy }: CreateChatProps) {
    return await this.chatRepository.save({
      title,
      hashtags,
      creator: { id: createdBy },
    });
  }

  async createMessage({ content, chatId, createdBy }: CreateMessageProps) {
    return await this.messageRepository.save({
      content,
      creator: {
        id: createdBy,
      },
      chat: {
        id: chatId,
      },
    });
  }
}
