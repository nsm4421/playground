import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { LessThan, Repository } from 'typeorm';
import { Feed } from './entity/feed.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { StorageService } from 'src/storage/storage.service';
import { fetchWithPagination } from 'src/utils/pageable.util';

interface FetchProps {
  page: number;
  pageSize?: number;
  lastId: number;
}

interface CreateProps {
  content: string;
  hashtags: string[];
  files: Express.Multer.File[];
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
    private readonly storageService: StorageService,
  ) {}

  async fetch({ page, pageSize, lastId }: FetchProps) {
    fetchWithPagination({
      repository: this.feedRepository,
      page,
      pageSize,
      where: {
        id: LessThan(lastId),
      },
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async create({ content, hashtags, files, createdBy }: CreateProps) {
    return await this.feedRepository.save({
      content,
      hashtags,
      images: files ? await this.saveImagesAndReturnPaths(files) : [],
      author: { id: createdBy },
    });
  }

  async modify({ id, content, hashtags, files, createdBy }: EditProps) {
    const feed = await this.feedRepository.findOneBy({ id });
    if (feed.author.id !== createdBy) {
      throw new BadRequestException('can modify only own data');
    } else if (feed.deletedAt !== null) {
      throw new NotFoundException('already deleted data');
    }
    feed.content = content;
    feed.hashtags = hashtags;
    feed.images = files ? await this.saveImagesAndReturnPaths(files) : [];
    return await this.feedRepository.save(feed);
  }

  async delete({ id }) {
    return await this.feedRepository.softDelete({ id });
  }

  private async saveImagesAndReturnPaths(files: Express.Multer.File[]) {
    console.debug(files);
    const imagePaths: string[] = [];
    if (files.length > 0) {
      for (const f of files) {
        const path = await this.storageService.handleUploadedFile(f);
        imagePaths.push(path);
      }
    }
    return imagePaths;
  }
}
