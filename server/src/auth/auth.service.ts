import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { compare, hash } from 'bcrypt';
import { User } from './entity/user.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { JwtService } from '@nestjs/jwt';

interface ValidateProps {
  username: string;
  password: string;
}

interface SignUpProps extends ValidateProps {
  nickname: string;
  email: string;
  profileImage: string;
}

interface EditProfileProps {
  id: string;
  nickname: string;
  profileImage?: string;
}

interface DecodedToken {
  username: string;
  sub: string;
  lat: number;
  exp: number;
}

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private readonly authRepository: Repository<User>,
    private readonly jwtService: JwtService,
  ) {}

  /** 회원가입
   * @param props
   * - username
   * - password
   * - email
   * - nickname
   * @returns 저장된 유저정보
   */
  async signUp(props: SignUpProps) {
    const hashedPassword = await hash(props.password, 10);
    const { password, ...data } = await this.authRepository.save({
      ...props,
      password: hashedPassword,
    });
    return data;
  }

  /** 로그인
   * @param user
   * Local Strategy를 사용해 얻은 유저
   * @returns access token
   */
  async signIn(user: any) {
    const payload = { username: user.username, sub: user.id };
    return await this.jwtService.signAsync(payload, { secret: '1221' }); // TODO : inject secret by .env file
  }

  /** 유저 가져오기
   * @param id
   */
  async get(id: string) {
    const user = await this.authRepository.findOneBy({ id });
    if (!user) {
      throw new NotFoundException('user not found');
    }
    const { password, ...payload } = user;
    return payload;
  }

  /** 인증정보 검증하기
   * @param
   * - username
   * - password
   * @returns 올바른 인증정보가 주어진 경우 유저객체를, 아니면 null을 반환
   */
  async validate({ username, password }: ValidateProps): Promise<User> {
    const user = await this.authRepository.findOneBy({ username });
    const isValid = user && (await compare(password, user.password));
    return isValid ? user : null;
  }

  /** 토큰 decoding
   * @param token
   */
  async decodeToken(token: string): Promise<DecodedToken> {
    try {
      return await this.jwtService.verify(token, {
        secret: process.env.JWT_SECRET ?? '1221',
      });
    } catch (error) {
      console.error(error);
      throw new UnauthorizedException('Invalid token');
    }
  }

  /** 회원가입
   * @param props
   * - nickname
   * - profileImage
   * @returns 업데이트된 유저정보
   */
  async editProfile({ id, nickname, profileImage }: EditProfileProps) {
    const user = await this.authRepository.findOneBy({
      id,
    });
    await this.authRepository.update(
      {
        id: id,
      },
      {
        nickname,
        ...(profileImage && { profileImage }),
      },
    );
    const { password, ...payload } = user;
    return payload;
  }
}
