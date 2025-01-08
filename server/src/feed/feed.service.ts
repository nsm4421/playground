import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { LessThan, Repository } from 'typeorm';
import { Feed } from './entity/feed.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { fetchWithPagination } from 'src/utils/pageable.util';

interface FetchProps {
  page: number;
  pageSize?: number;
  lastId?: number;
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

  async fetch({ page, pageSize, lastId }: FetchProps) {
    return await fetchWithPagination({
      repository: this.feedRepository,
      page,
      pageSize,
      where: lastId && {
        id: LessThan(lastId),
      },
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async create({ content, hashtags, images, createdBy }: CreateProps) {
    return await this.feedRepository.save({
      content,
      hashtags,
      images,
      author: { id: createdBy },
    });
  }

  async modify({ id, content, hashtags, images, createdBy }: EditProps) {
    const feed = await this.feedRepository.findOneBy({ id });
    if (feed.author.id !== createdBy) {
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
