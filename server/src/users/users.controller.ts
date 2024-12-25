import {
  Body,
  Controller,
  Get,
  HttpCode,
  Post,
  Req,
  Res,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { Request, Response } from 'express';
import { SignInReqDto } from './dto/sign-in.dto';
import { SignUpReqDto } from './dto/sign-up.dto';
import { CurrentUserDto } from './dto/current-user';

@Controller('api/users')
export class UsersController {
  constructor(private readonly userService: UsersService) {}

  @Post('sign-up')
  @HttpCode(201)
  async signUp(@Body() dto: SignUpReqDto) {
    const id = await this.userService.signUp(dto);
    return {
      message: 'sign-up sucess',
      payload: {
        id,
      },
    };
  }

  @Post('sign-in')
  async signIn(
    @Body() dto: SignInReqDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    const jwt = await this.userService.signIn(dto);
    response.cookie('jwt', jwt, { httpOnly: true });
    return {
      message: 'sign-in success',
    };
  }

  @Get('current-user')
  async currentUser(@Req() request: Request): Promise<CurrentUserDto> {
    const jwt = request.cookies['jwt'];
    return await this.userService.currentUser(jwt);
  }

  @Post('sign-out')
  async signOut(@Res({ passthrough: true }) response: Response): Promise<void> {
    response.clearCookie('jwt');
  }
}
