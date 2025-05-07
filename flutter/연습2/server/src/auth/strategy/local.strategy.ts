import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-local';
import { AuthService } from '../auth.service';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthService) {
    super();
  }

  /** LocalStrategy
   * client가 reuqest body에 username, password를 실어서 요청을 보내면
   * 이를 가로채서 유저정보를 검증하고 request에 user를 붙여서 controller에 요청을 처리하도록 할 것임
   * @param username
   * @param password
   * @returns user
   */
  async validate(username: string, password: string) {
    const user = await this.authService.validate({ username, password });
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
