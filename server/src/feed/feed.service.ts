import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { Feed } from './entity/feed.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { FeedReaction } from './entity/feed_reaction.entity';

interface FetchFeedsProps {
  page: number;
  pageSize?: number;
  currentUid: string;
}

interface CreateFeedProps {
  content: string;
  hashtags: string[];
  images: string[];
  createdBy: string;
}

interface EditFeedProps extends CreateFeedProps {
  id: number;
}

interface EditLikeProps {
  feedId: number;
  currentUid: string;
}

@Injectable()
export class FeedService {
  constructor(
    @InjectRepository(Feed)
    private readonly feedRepository: Repository<Feed>,
    @InjectRepository(FeedReaction)
    private readonly feedReactionRepository: Repository<FeedReaction>,
  ) {}

  async fetchFeeds({ page, pageSize, currentUid }: FetchFeedsProps) {
    const [data, totalCount] = await this.feedRepository
      .createQueryBuilder('feed')
      // 유저 테이블 조인
      .leftJoin('feed.creator', 'user')
      .addSelect(['user.nickname', 'user.profileImage'])
      // 좋아요 테이블 조인
      .leftJoin(
        'feed.reactions',
        'reaction',
        `reaction.createdBy = '${currentUid}'`,
      )
      .addSelect(['reaction.id', 'reaction.createdAt'])
      // pagining
      .skip((page - 1) * pageSize)
      .take(pageSize)
      .orderBy('feed.createdAt', 'DESC')
      .getManyAndCount();

    return {
      data,
      totalCount,
      pageSize,
      currentPage: page,
      totalPages: Math.ceil(totalCount / pageSize),
    };
  }

  async createFeed({ content, hashtags, images, createdBy }: CreateFeedProps) {
    return await this.feedRepository.save({
      content,
      hashtags,
      images,
      creator: { id: createdBy },
    });
  }

  async modifyFeed({
    id,
    content,
    hashtags,
    images,
    createdBy,
  }: EditFeedProps) {
    const feed = await this.feedRepository.findOneBy({ id });
    if (feed.creator.id !== createdBy) {
      throw new BadRequestException('can modify only own data');
    } else if (feed.deletedAt !== null) {
      throw new NotFoundException('already deleted data');
    }
    feed.content = content;
    feed.hashtags = hashtags;
    feed.images = images;
    return await this.feedRepository.save(feed);
  }

  async deleteFeed(feedId: number) {
    return await this.feedRepository.softDelete({ id: feedId });
  }

  async countLike(feedId: number) {
    return await this.feedReactionRepository.countBy({
      feed: {
        id: feedId,
      },
    });
  }

  async createLike({ feedId, currentUid }: EditLikeProps) {
    return await this.feedReactionRepository.save({
      feedId,
      creator: {
        id: currentUid,
      },
    });
  }

  async deleteLike({ feedId, currentUid }: EditLikeProps) {
    return await this.feedReactionRepository.delete({
      feed: { id: feedId },
      creator: { id: currentUid },
    });
  }
}
