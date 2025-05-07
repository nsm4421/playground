import { IsNumber, IsString, Length } from 'class-validator';

export class CreateFeedCommentDto {
  @IsString()
  @Length(0, 1000)
  content: string;

  @IsNumber()
  feedId: number;
}

export class ModifyFeedCommentDto {
  @IsString()
  @Length(0, 1000)
  content: string;

  @IsNumber()
  commentId: number;
}
