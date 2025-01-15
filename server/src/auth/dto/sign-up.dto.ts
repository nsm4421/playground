import { IsString, IsEmail, Length } from 'class-validator';
import { SignInReqDto } from './sign-in.dto';

export class SignUpReqDto extends SignInReqDto {
  @IsEmail()
  @Length(5, 50)
  email: string;

  @IsString()
  @Length(3, 30)
  nickname: string;
}
