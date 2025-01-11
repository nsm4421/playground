import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Chat } from './entity/chat.entity';
import { InjectRepository } from '@nestjs/typeorm';

interface FetchProps {
  page: number;
  pageSize?: number;
}

interface CreateProps {
  title: string;
  hashtags: string[];
  createdBy: string;
}

@Injectable()
export class ChatService {
  constructor(
    @InjectRepository(Chat)
    private readonly chatRepository: Repository<Chat>,
  ) {}

  async fetch({ page, pageSize }: FetchProps) {
    const [data, totalCount] = await this.chatRepository
      .createQueryBuilder('chat')
      .leftJoinAndSelect('chat.author', 'user')
      .select(['chat', 'user.id', 'user.username'])
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

  async create({ title, hashtags, createdBy }: CreateProps) {
    return await this.chatRepository.save({
      title,
      hashtags,
      creater: { id: createdBy },
    });
  }
}
