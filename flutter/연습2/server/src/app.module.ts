import { Module } from '@nestjs/common';
import { ServeStaticModule } from '@nestjs/serve-static';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { User } from './auth/entity/user.entity';
import { FeedModule } from './feed/feed.module';
import { ChatModule } from './chat/chat.module';
import { join } from 'path';

@Module({
  imports: [
    // TODO : inject secret by .env file
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'karma',
      password: '1221',
      database: 'dev_db',
      autoLoadEntities: true,
      synchronize: true, // only on dev mode
      entities: [User],
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'upload'),
      serveRoot: '/upload',
    }),
    AuthModule,
    FeedModule,
    ChatModule,
  ],
  providers: [],
})
export class AppModule {}
