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
import {
  CreateFeedCommentDto,
  ModifyFeedCommentDto,
} from './dto/edit-comment.dto';

@Controller('api/feed')
@UseGuards(JwtAuthGuard)
export class FeedController {
  constructor(private readonly feedService: FeedService) {}

  /// feed
  @Get()
  async fetch(
    @Request() request,
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
  ) {
    return await this.feedService.fetchFeeds({
      page,
      pageSize,
      currentUid: request.user.sub,
    });
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
      payload: await this.feedService.createFeed({
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
      payload: await this.feedService.modifyFeed({
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
  async delete(@Request() request, @Param('id') id: number) {
    return await this.feedService.deleteFeed({
      id,
      currentUid: request.user.sub,
    });
  }

  /// feed reaction
  @Get('reaction')
  async countLike(@Query('id') feedId: number) {
    return await this.feedService.countLike(feedId);
  }

  @Post('reaction')
  async createLike(@Request() request, @Query('id') feedId: number) {
    return await this.feedService.createLike({
      feedId,
      currentUid: request.user.sub,
    });
  }

  @Delete('reaction/:id')
  async deleteLike(@Request() request, @Param('id') feedId: number) {
    return await this.feedService.deleteLike({
      feedId,
      currentUid: request.user.sub,
    });
  }

  /// feed comment
  @Get('comment/:feedId')
  async fetchComments(
    @Param('feedId') feedId: number,
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
  ) {
    return await this.feedService.fetchComments({
      page,
      pageSize,
      feedId,
    });
  }

  @Post('comment')
  async createComment(@Request() request, @Body() dto: CreateFeedCommentDto) {
    return await this.feedService.createComment({
      ...dto,
      currentUid: request.user.sub,
    });
  }

  @Put('comment')
  async modifyComment(@Request() request, @Body() dto: ModifyFeedCommentDto) {
    return await this.feedService.modifyComment({
      ...dto,
      currentUid: request.user.sub,
    });
  }

  @Delete('comment/:id')
  async deleteComment(@Request() request, @Param('id') commentId: number) {
    return await this.feedService.deleteComment({
      commentId,
      currentUid: request.user.sub,
    });
  }
}
