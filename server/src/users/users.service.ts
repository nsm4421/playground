import {
  BadRequestException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserEntity } from './entity/user.entity';
import { compare, hash } from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { CurrentUserDto } from './dto/current-user';

const SALT_ROUND = 10;

interface SignUpProps {
  email: string;
  password: string;
  username: string;
}

interface SignInProps {
  email: string;
  password: string;
}

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(UserEntity)
    private readonly userRepository: Repository<UserEntity>,
    private readonly jwtService: JwtService,
  ) {}

  /**
   * 회원가입
   * @param email
   * @param password
   * @param username
   * @returns 유저 id
   */
  async signUp({
    email,
    password: rawPassword,
    username,
  }: SignUpProps): Promise<string> {
    const hashedPassword = await hash(rawPassword, SALT_ROUND);

    const { id } = await this.userRepository.save({
      email,
      password: hashedPassword,
      username,
    });

    return id;
  }

  /**
   * 로그인
   * @param email
   * @param password
   * @returns id, username, email, jwt
   */
  async signIn({ email, password: rawPassword }: SignInProps) {
    const user = await this.userRepository.findOneBy({ email });
    if (!user) {
      throw new BadRequestException('Invalid Crendential');
    }

    const isPasswordMatch = await compare(rawPassword, user.password);
    if (!isPasswordMatch) {
      throw new BadRequestException('Invalid Crendential');
    }

    const jwt = await this.jwtService.signAsync({
      id: user.id,
    });

    const { password, ...res } = user;
    return {
      ...res,
      jwt,
    };
  }

  /**
   * 현재 유저정보
   * @param jwt
   * @returns id, username, email
   */
  async currentUser(jwt: string): Promise<CurrentUserDto> {
    const { id } = await this.jwtService.verifyAsync(jwt);
    if (!id) {
      throw new UnauthorizedException();
    }
    const user = await this.userRepository.findOneBy({ id });
    if (!user) {
      throw new UnauthorizedException();
    }
    const { password, ...payload } = user;
    return payload;
  }
}
