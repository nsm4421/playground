import { IsArray, IsString, Length } from 'class-validator';

export class CreateChatDto {
  @Length(3, 50)
  @IsString()
  title: string;

  @IsArray()
  hashtags: string[];
}
