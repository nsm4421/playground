import { IsString, Length } from 'class-validator';

export class SignInReqDto {
  @Length(6, 30)
  username: string;

  @IsString()
  @Length(8, 30)
  password: string;
}
