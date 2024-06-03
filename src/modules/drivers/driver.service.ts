import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CreateDriverDto } from './dtos/create-driver.dto';
import { UpdateDriverDto } from './dtos/update-driver.dto';

@Injectable()
export class DriverService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateDriverDto) {
    return this.prisma.driver.create({ data });
  }

  async findAll() {
    return this.prisma.driver.findMany();
  }

  async findOne(id: number) {
    return this.prisma.driver.findUnique({ where: { driver_id: id } });
  }

  async update(id: number, data: UpdateDriverDto) {
    return this.prisma.driver.update({ where: { driver_id: id }, data });
  }

  async remove(id: number) {
    return this.prisma.driver.delete({ where: { driver_id: id } });
  }
}