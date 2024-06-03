import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CreateUserDto } from './dtos/create-user.dto';
import { UpdateUserDto } from './dtos/update-user.dto';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) { }

  async create(usr: CreateUserDto) {
    return this.prisma.user.create({ data: usr });
  }

  async findAll() {
    return this.prisma.user.findMany();
  }

  async findOne(id: number) {
    return this.prisma.user.findUnique({ where: { user_id: id } });
  }

  async update(id: number, data: UpdateUserDto) {
    return this.prisma.user.update({ where: { user_id: id }, data });
  }

  async remove(id: number) {
    return this.prisma.user.delete({ where: { user_id: id } });
  }
}
