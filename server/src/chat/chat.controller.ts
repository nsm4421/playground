import { Body, Controller, Post, UseGuards, Request } from '@nestjs/common';
import { ChatService } from './chat.service';
import { JwtAuthGuard } from 'src/auth/guard/jwt.guard';
import { CreateChatDto } from './dto/create-chat.dto';

@Controller('api/chat')
@UseGuards(JwtAuthGuard)
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post()
  async create(@Request() request, @Body() { title, hashtags }: CreateChatDto) {
    const data = {
      title,
      hashtags,
      createdBy: request.user.sub,
    };
    console.table(data);
    return await this.chatService.create({
      title,
      hashtags,
      createdBy: request.user.sub,
    });
  }
}
