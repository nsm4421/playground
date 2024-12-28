import { IsString, Length } from 'class-validator';

export class SignInReqDto {
  @Length(5, 50)
  username: string;

  @IsString()
  @Length(5, 50)
  password: string;
}
