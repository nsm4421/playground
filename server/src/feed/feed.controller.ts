import {
  Body,
  Controller,
  Post,
  UseGuards,
  UseInterceptors,
  Request,
  UploadedFiles,
  Query,
  Get,
  Delete,
  Param,
  Put,
} from '@nestjs/common';
import { FeedService } from './feed.service';
import { CreateFeedDto, ModifyFeedDto } from './dto/edit-feed.dto';
import { JwtAuthGuard } from 'src/auth/guard/jwt.guard';
import { genMultiFileMulterOption } from 'src/utils/upload.util';

@Controller('api/feed')
@UseGuards(JwtAuthGuard)
export class FeedController {
  constructor(private readonly feedService: FeedService) {}

  @Get()
  async fetch(
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
  ) {
    console.debug(`page:${page}|pageSize:${pageSize}`);
    return await this.feedService.fetch({ page, pageSize });
  }

  @Post()
  @UseInterceptors(
    genMultiFileMulterOption({
      fileKey: 'files',
      destination: './upload/feed',
      maxFileNum: 5,
    }),
  )
  async create(
    @Body() { content, hashtags }: CreateFeedDto,
    @Request() request,
    @UploadedFiles() files: Express.Multer.File[],
  ) {
    return {
      message: 'feed created',
      payload: await this.feedService.create({
        content,
        hashtags: hashtags.split('|'),
        images: files
          ? files.map((file) => `/upload/feed/${file.filename}`)
          : [],
        createdBy: request.user.sub,
      }),
    };
  }

  @Put()
  @UseInterceptors(
    genMultiFileMulterOption({
      fileKey: 'files',
      destination: './upload/feed',
      maxFileNum: 5,
    }),
  )
  async modify(
    @Body() { id, content, hashtags }: ModifyFeedDto,
    @Request() request,
    @UploadedFiles() files: Express.Multer.File[],
  ) {
    return {
      message: 'feed created',
      payload: await this.feedService.modify({
        id,
        content,
        hashtags: hashtags.split('|'),
        images: files
          ? files.map((file) => `/upload/feed/${file.filename}`)
          : [],
        createdBy: request.user.sub,
      }),
    };
  }

  @Delete(':id')
  async delete(@Param('id') id: number) {
    return await this.feedService.delete({ id });
  }
}
