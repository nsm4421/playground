import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET ?? '1221',
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
