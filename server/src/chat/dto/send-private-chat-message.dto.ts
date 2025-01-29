import { IsNotEmpty, IsString, Length } from 'class-validator';

export class SendPrivateChatMessageDto {
  @Length(1, 1000)
  @IsString()
  @IsNotEmpty()
  content: string;

  @IsString()
  @IsNotEmpty()
  receiverId: string;
}
