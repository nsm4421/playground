import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: '1221', // TODO : 환경변수로 주입
    });
  }

  /** JwtStrategy
   * client로 받아 Header의 Bearer Token을 사용해 유저정보를 가져옴
   * @param username
   * @param password
   * @returns user
   */
  async validate(payload: any) {
    return payload;
  }
}
