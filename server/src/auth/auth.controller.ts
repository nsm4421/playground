import {
  Body,
  Controller,
  HttpCode,
  Post,
  UseGuards,
  Request,
  Get,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpReqDto } from './dto/sign-up.dto';
import { LocalAuthGuard } from './guard/local.guard';
import { JwtAuthGuard } from './guard/jwt.guard';

@Controller('api/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @HttpCode(201)
  @Post('sign-up')
  async signUp(@Body() dto: SignUpReqDto) {
    return {
      message: 'sign up success',
      payload: {
        user: await this.authService.signUp(dto),
      },
    };
  }

  @UseGuards(LocalAuthGuard)
  @Post('sign-in')
  async signIn(@Request() request) {
    return {
      message: 'sign in success',
      payload: {
        access_token: await this.authService.signIn(request.user),
      },
    };
  }

  @UseGuards(JwtAuthGuard)
  @Get()
  async currentUser(@Request() request) {
    const id = request.user.sub;
    return {
      message: 'fetching current user info success',
      payload: {
        ...(await this.authService.get(id)),
      },
    };
  }
}
