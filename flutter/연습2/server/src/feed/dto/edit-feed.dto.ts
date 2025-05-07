import { IsNumber, IsString } from 'class-validator';

export class CreateFeedDto {
  @IsString()
  content: string;

  @IsString()
  hashtags: string;
}

export class ModifyFeedDto extends CreateFeedDto {
  @IsNumber()
  id: number;
}
