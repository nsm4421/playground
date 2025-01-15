import { Exclude } from 'class-transformer';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, nullable: false, length: 50 })
  username: string;

  @Column({ unique: true, nullable: false, length: 50 })
  nickname: string;

  @Column({ unique: true, nullable: false, length: 50 })
  email: string;

  @Column({ nullable: false, length: 300 })
  profileImage: string;

  @Exclude({ toPlainOnly: true })
  @Column({ nullable: false, length: 255 })
  password: string;

  @CreateDateColumn()
  createdAt: string;

  @UpdateDateColumn()
  updatedAt: string;
}
