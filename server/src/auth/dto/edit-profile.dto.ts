import { IsString, Length } from 'class-validator';

export class EditProfileReqDto {
  @IsString()
  @Length(3, 30)
  nickname: string;
}
