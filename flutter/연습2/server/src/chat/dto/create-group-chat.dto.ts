import { IsArray, IsString, Length } from 'class-validator';

export class CreateGroupChatDto {
  @Length(3, 50)
  @IsString()
  title: string;

  @IsArray()
  hashtags: string[];
}
