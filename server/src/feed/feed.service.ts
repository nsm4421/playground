import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { Feed } from './entity/feed.entity';
import { InjectRepository } from '@nestjs/typeorm';

interface FetchProps {
  page: number;
  pageSize?: number;
}

interface CreateProps {
  content: string;
  hashtags: string[];
  images: string[];
  createdBy: string;
}

interface EditProps extends CreateProps {
  id: number;
}

@Injectable()
export class FeedService {
  constructor(
    @InjectRepository(Feed)
    private readonly feedRepository: Repository<Feed>,
  ) {}

  async fetch({ page, pageSize }: FetchProps) {
    const [data, totalCount] = await this.feedRepository
      .createQueryBuilder('feed')
      .leftJoinAndSelect('feed.creator', 'user')
      .select(['feed', 'user.id', 'user.username'])
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

  async create({ content, hashtags, images, createdBy }: CreateProps) {
    return await this.feedRepository.save({
      content,
      hashtags,
      images,
      creator: { id: createdBy },
    });
  }

  async modify({ id, content, hashtags, images, createdBy }: EditProps) {
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

  async delete({ id }) {
    return await this.feedRepository.softDelete({ id });
  }
}
