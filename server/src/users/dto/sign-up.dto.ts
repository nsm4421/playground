import { IsEmail, IsString, Length } from 'class-validator';

export class SignUpReqDto {
  @IsEmail()
  @Length(5, 50)
  email: string;

  @IsString()
  @Length(5, 50)
  password: string;

  @IsString()
  @Length(5, 50)
  username: string;
}
