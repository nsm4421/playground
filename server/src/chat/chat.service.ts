import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Chat } from './entity/chat.entity';
import { InjectRepository } from '@nestjs/typeorm';

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

  async create({ title, hashtags, createdBy }: CreateProps) {
    return await this.chatRepository.save({
      title,
      hashtags,
      creater: { id: createdBy },
    });
  }
}
