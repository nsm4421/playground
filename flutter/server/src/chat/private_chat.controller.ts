import { Controller, UseGuards, Request, Get, Query } from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/guard/jwt.guard';
import { PrivateChatService } from './private_chat.service';

@Controller('api/private-chat')
@UseGuards(JwtAuthGuard)
export class PrivateChatController {
  constructor(private readonly chatService: PrivateChatService) {}

  @Get()
  async fetchChats(@Request() request) {
    console.debug(`fetchChats`);
    return await this.chatService.fetchLastestMessages({
      currentUid: request.user.sub,
    });
  }

  @Get('message')
  async fetchMessages(
    @Request() request,
    @Query('opponentUid') opponentUid: string,
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
    @Query('lastMessageId') lastMessageId?: number,
  ) {
    console.debug(
      `fetchMessage|lastMessageId:${lastMessageId}|opponentUid:${opponentUid}|page:${page}|pageSize:${pageSize}`,
    );
    return await this.chatService.fetchMessages({
      page,
      pageSize,
      currentUid: request.user.sub,
      opponentUid,
      lastMessageId,
    });
  }
}
