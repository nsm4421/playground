import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './users/users.module';
import { UserEntity } from './users/entity/user.entity';

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
      entities: [UserEntity],
    }),

    UsersModule,
  ],
})
export class AppModule {}
