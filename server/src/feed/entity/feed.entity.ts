import { User } from 'src/auth/entity/user.entity';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('feeds')
export class Feed {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false, length: 1000 })
  content: string;

  @Column('text', { array: true, default: [] })
  images: string[];

  @Column('text', { array: true, default: [] })
  hashtags: string[];

  @ManyToOne(() => User, (user) => user.id, { nullable: false })
  @JoinColumn({ name: 'createdBy' })
  author: User;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @DeleteDateColumn()
  deletedAt?: Date;
}
