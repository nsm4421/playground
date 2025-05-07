import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { GroupChat } from './entity/group_chat.entity';
import { GroupChatMessage } from './entity/group_chat_message.entity';

interface FetchChatsProps {
  page: number;
  pageSize?: number;
}

interface CreateChatProps {
  title: string;
  hashtags: string[];
  currentUid: string;
}

interface DeleteChatProps {
  currentUid: string;
  id: string;
}

interface CreateMessageProps {
  content: string;
  chatId: string;
  currentUid: string;
}

@Injectable()
export class GroupChatService {
  constructor(
    @InjectRepository(GroupChat)
    private readonly chatRepository: Repository<GroupChat>,
    @InjectRepository(GroupChatMessage)
    private readonly messageRepository: Repository<GroupChatMessage>,
  ) {}

  async fetchChats({ page, pageSize }: FetchChatsProps) {
    const [data, totalCount] = await this.chatRepository
      .createQueryBuilder('group_chat')
      .leftJoinAndSelect('group_chat.creator', 'user')
      .select(['group_chat', 'user.id', 'user.nickname', 'user.profileImage'])
      .skip((page - 1) * pageSize)
      .take(pageSize)
      .orderBy('group_chat.updatedAt', 'DESC')
      .getManyAndCount();
    return {
      data,
      totalCount,
      pageSize,
      currentPage: page,
      totalPages: Math.ceil(totalCount / pageSize),
    };
  }

  async createChat({ title, hashtags, currentUid }: CreateChatProps) {
    return await this.chatRepository.save({
      title,
      hashtags,
      creator: { id: currentUid },
    });
  }

  async deleteChat({ id, currentUid }: DeleteChatProps) {
    const chat = await this.chatRepository.findOne({
      where: { id },
      relations: ['creator'],
    });
    if (!chat) {
      throw new NotFoundException(`chat id ${id} not founded`);
    } else if (chat.creator.id !== currentUid) {
      throw new BadRequestException('only creator can delete chat');
    }
    return await this.chatRepository.softDelete({ id });
  }

  async createMessage({ content, chatId, currentUid }: CreateMessageProps) {
    return await this.messageRepository.save({
      content,
      creator: {
        id: currentUid,
      },
      chat: {
        id: chatId,
      },
    });
  }
}
