import {
  Body,
  Controller,
  HttpCode,
  Post,
  UseGuards,
  Request,
  Get,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpReqDto } from './dto/sign-up.dto';
import { LocalAuthGuard } from './guard/local.guard';
import { JwtAuthGuard } from './guard/jwt.guard';
import { genSingleFileMulterOption } from 'src/utils/upload.util';
import { EditProfileReqDto } from './dto/edit-profile.dto';

@Controller('api/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @HttpCode(201)
  @Post('sign-up')
  @UseInterceptors(
    genSingleFileMulterOption({
      fileKey: 'file',
      destination: './upload/auth',
    }),
  )
  async signUp(
    @Body() dto: SignUpReqDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return {
      message: 'sign up success',
      payload: {
        user: await this.authService.signUp({
          ...dto,
          profileImage: `/upload/auth/${file.filename}`,
        }),
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

  @UseGuards(JwtAuthGuard)
  @UseInterceptors(
    genSingleFileMulterOption({
      fileKey: 'file',
      destination: './upload/auth',
    }),
  )
  @Post('edit-profile')
  async editProfile(
    @Body() { nickname }: EditProfileReqDto,
    @Request() request,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return {
      message: 'profile edited successfully',
      payload: {
        user: await this.authService.editProfile({
          id: request.user.sub,
          nickname,
          ...(file && { profileImage: `/upload/auth/${file.filename}` }),
        }),
      },
    };
  }
}
