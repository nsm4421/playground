import { Module } from '@nestjs/common';
import { FeedService } from './feed.service';
import { FeedController } from './feed.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Feed } from './entity/feed.entity';
import { FeedReaction } from './entity/feed_reaction.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Feed]),
    TypeOrmModule.forFeature([FeedReaction]),
  ],
  controllers: [FeedController],
  providers: [FeedService],
})
export class FeedModule {}
