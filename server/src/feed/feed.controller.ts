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
import { FileInterceptor } from '@nestjs/platform-express';
import { JwtAuthGuard } from 'src/auth/guard/jwt.guard';

@Controller('api/feed')
@UseGuards(JwtAuthGuard)
export class FeedController {
  constructor(private readonly feedService: FeedService) {}

  @Get()
  async fetch(
    @Query('page') page: number,
    @Query('pageSize') pageSize?: number,
    @Query('lastId') lastId?: number,
  ) {
    return await this.feedService.fetch({ page, pageSize, lastId });
  }

  @Post()
  @UseInterceptors(FileInterceptor('files'))
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
        files: files ?? [],
        createdBy: request.user.sub,
      }),
    };
  }

  @Put()
  @UseInterceptors(FileInterceptor('files'))
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
        files: files ?? [],
        createdBy: request.user.sub,
      }),
    };
  }

  @Delete(':id')
  async delete(@Param('id') id: number) {
    return await this.feedService.delete({ id });
  }
}
