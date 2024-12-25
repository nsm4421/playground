import { IsString, IsEmail, Length } from 'class-validator';

export class SignInReqDto {
  @IsEmail()
  @Length(5, 50)
  email: string;

  @IsString()
  @Length(5, 50)
  password: string;
}
