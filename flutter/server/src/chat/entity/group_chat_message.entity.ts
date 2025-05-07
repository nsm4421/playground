import { User } from 'src/auth/entity/user.entity';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { GroupChat } from './group_chat.entity';

@Entity('group_chat_messages')
export class GroupChatMessage {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ nullable: false, length: 1000 })
  content: string;

  @ManyToOne(() => GroupChat, (chat) => chat.id, { nullable: false })
  @JoinColumn({ name: 'chatId' })
  chat: GroupChat;

  @ManyToOne(() => User, (user) => user.id, { nullable: false })
  @JoinColumn({ name: 'createdBy' })
  creator: User;

  @CreateDateColumn()
  createdAt: string;

  @UpdateDateColumn()
  updatedAt: string;

  @DeleteDateColumn()
  deletedAt?: Date;
}
