import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { Feed } from './entity/feed.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { FeedReaction } from './entity/feed_reaction.entity';
import { FeedComment } from './entity/feed_comment.entity';

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

interface DeleteFeedProps {
  id: number;
  currentUid: string;
}

interface EditLikeProps {
  feedId: number;
  currentUid: string;
}

interface FetchCommentsProps {
  page: number;
  pageSize?: number;
  feedId: number;
}

interface CreateCommentProps {
  feedId: number;
  currentUid: string;
  content: string;
}

interface ModifyCommentProps {
  commentId: number;
  currentUid: string;
  content: string;
}

interface DeleteCommentProps {
  commentId: number;
  currentUid: string;
}

@Injectable()
export class FeedService {
  constructor(
    @InjectRepository(Feed)
    private readonly feedRepository: Repository<Feed>,
    @InjectRepository(FeedComment)
    private readonly feedCommentRepository: Repository<FeedComment>,
    @InjectRepository(FeedReaction)
    private readonly feedReactionRepository: Repository<FeedReaction>,
  ) {}

  /// 피드
  async fetchFeeds({ page, pageSize, currentUid }: FetchFeedsProps) {
    const [data, totalCount] = await this.feedRepository
      .createQueryBuilder('feed')
      // 유저 테이블 조인
      .leftJoin('feed.creator', 'user')
      .addSelect(['user.id', 'user.nickname', 'user.profileImage'])
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
    const feed = await this.feedRepository.findOne({
      where: { id },
      relations: ['creator'],
    });
    if (!feed || feed.deletedAt) {
      throw new NotFoundException('already deleted data');
    } else if (feed.creator.id !== createdBy) {
      throw new BadRequestException('can modify only own data');
    }
    feed.content = content;
    feed.hashtags = hashtags;
    feed.images = images;
    return await this.feedRepository.save(feed);
  }

  async deleteFeed({ id, currentUid }: DeleteFeedProps) {
    const feed = await this.feedRepository.findOne({
      where: { id },
      relations: ['creator'],
    });
    if (!feed || feed.deletedAt) {
      throw new NotFoundException('already deleted data');
    } else if (feed.creator.id !== currentUid) {
      throw new BadRequestException('can delete only own data');
    }

    return await this.feedRepository.softDelete({ id });
  }

  /// 좋아요
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

  /// 댓글
  async fetchComments({ page, pageSize, feedId }: FetchCommentsProps) {
    const [data, totalCount] = await this.feedCommentRepository
      .createQueryBuilder('feed_comment')
      // 피드 아이디로 필터링
      .where('feed_comment.feedId = :feedId', { feedId })
      // 유저 테이블 조인
      .leftJoin('feed_comment.creator', 'user')
      .addSelect(['user.id', 'user.nickname', 'user.profileImage'])
      // pagining
      .skip((page - 1) * pageSize)
      .take(pageSize)
      .orderBy('feed_comment.createdAt', 'DESC')
      .getManyAndCount();

    return {
      data,
      totalCount,
      pageSize,
      currentPage: page,
      totalPages: Math.ceil(totalCount / pageSize),
    };
  }

  async createComment({ feedId, currentUid, content }: CreateCommentProps) {
    return await this.feedCommentRepository.save({
      feed: { id: feedId },
      content,
      creator: { id: currentUid },
    });
  }

  async modifyComment({ currentUid, content, commentId }: ModifyCommentProps) {
    const comment = await this.feedCommentRepository.findOneBy({
      id: commentId,
    });
    if (!comment || comment.deletedAt) {
      throw new NotFoundException('comment not found');
    } else if (comment.creator.id !== currentUid) {
      throw new BadRequestException('only author can edit comment');
    }
    return await this.feedCommentRepository.update(
      { id: commentId },
      {
        content,
      },
    );
  }

  async deleteComment({ commentId, currentUid }: DeleteCommentProps) {
    const comment = await this.feedCommentRepository.findOne({
      where: { id: commentId },
      relations: ['creator'],
    });
    if (!comment || comment.deletedAt) {
      throw new NotFoundException('comment not found');
    } else if (comment.creator.id !== currentUid) {
      throw new BadRequestException('only author can edit comment');
    }
    return await this.feedCommentRepository.softDelete({ id: commentId });
  }
}
