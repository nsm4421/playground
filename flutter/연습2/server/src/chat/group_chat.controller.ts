import {
  Body,
  Controller,
  Post,
  UseGuards,
  Request,
  Get,
  Query,
  Delete,
  Param,
} from '@nestjs/common';
import { GroupChatService } from './group_chat.service';
import { JwtAuthGuard } from 'src/auth/guard/jwt.guard';
import { CreateGroupChatDto } from './dto/create-group-chat.dto';

@Controller('api/group-chat')
@UseGuards(JwtAuthGuard)
export class GroupChatController {
  constructor(private readonly chatService: GroupChatService) {}

  @Get()
  async fetchChats(
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
  ) {
    console.debug(`chat|page:${page}|pageSize:${pageSize}`);
    return await this.chatService.fetchChats({ page, pageSize });
  }

  @Post()
  async createChat(
    @Request() request,
    @Body() { title, hashtags }: CreateGroupChatDto,
  ) {
    return await this.chatService.createChat({
      title,
      hashtags,
      currentUid: request.user.sub,
    });
  }

  @Delete(':id')
  async deleteChat(@Request() request, @Param('id') id: string) {
    return await this.chatService.deleteChat({
      id,
      currentUid: request.user.sub,
    });
  }
}
