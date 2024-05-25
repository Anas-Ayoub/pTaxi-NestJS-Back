import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { BookService } from './book.service';
import { Book } from '@prisma/client';
import { log } from 'console';

@Controller('books')
export class BookController {

    constructor(private readonly bookService: BookService) { }

    @Get()
    async getAllBook(): Promise<Book[]> {
        console.log("IM IN ALL BOOKS");

        return this.bookService.findAll();
    }

    @Get(':id')
    async getBook(@Param('id') id: number): Promise<Book | null> {
        console.log("IM IN ONE BOOKS");
        return this.bookService.findOne(id);
    }

    @Post()
    async postBook(@Body() book: Book): Promise<Book> {
        return this.bookService.create(book);
    }

    @Delete(':id')
    async deleteBook(@Param('id') id: number): Promise<Book> {
        return this.bookService.remove(id);
    }

    @Put(':id')
    async updateBook(@Param('id') id: number, @Body() book: Book): Promise<Book> {
        return this.bookService.update(id, book);
    }



}
