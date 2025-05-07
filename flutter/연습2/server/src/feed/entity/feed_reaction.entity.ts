import { User } from 'src/auth/entity/user.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  Unique,
} from 'typeorm';
import { Feed } from './feed.entity';

@Entity('feed_reactions')
@Unique(['feedId', 'createdBy'])
export class FeedReaction {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  feedId: number;

  @Column({ nullable: false })
  createdBy: string;

  @ManyToOne(() => Feed, (feed) => feed.id, { nullable: false })
  @JoinColumn({ name: 'feedId' })
  feed: Feed;

  @ManyToOne(() => User, (user) => user.id, { nullable: false })
  @JoinColumn({ name: 'createdBy' })
  creator: User;

  @CreateDateColumn()
  createdAt: Date;
}
