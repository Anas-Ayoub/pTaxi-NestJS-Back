import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { Book } from '@prisma/client';

@Injectable()
export class BookService {
    constructor(private readonly prisma: PrismaService) { }

    async findAll(): Promise<Book[]> {
        return this.prisma.book.findMany();
    }

    async findOne(id: number): Promise<Book | null> {
        console.log(id);
        return this.prisma.book.findUnique({

            where: { id: Number(id) },
        });
    }

    async create(data: Book): Promise<Book> {
        return this.prisma.book.create({ data });
    }

    async update(id: number, data: Book): Promise<Book> {
        return this.prisma.book.update({
            where: { id: Number(id) },
            data: { title: data.title, description: data.description },
        });
    }

    async remove(id: number): Promise<Book> {
        return this.prisma.book.delete({
            where: { id: Number(id) },
        });
    }
}
