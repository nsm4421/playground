import { Module } from '@nestjs/common';
import { GroupChatController } from './group_chat.controller';
import { GroupChatService } from './group_chat.service';
import { ChatGateWay } from './chat.gateway';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GroupChat } from './entity/group_chat.entity';
import { GroupChatMessage } from './entity/group_chat_message.entity';
import { AuthModule } from 'src/auth/auth.module';
import { PrivateChatMessage } from './entity/private_chat_message.entity';
import { PrivateChatService } from './private_chat.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([GroupChat]),
    TypeOrmModule.forFeature([GroupChatMessage]),
    TypeOrmModule.forFeature([PrivateChatMessage]),
    AuthModule,
  ],
  controllers: [GroupChatController],
  providers: [GroupChatService, PrivateChatService, ChatGateWay],
})
export class ChatModule {}
