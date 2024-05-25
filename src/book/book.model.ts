import { Prisma } from "@prisma/client";

export class Book implements Prisma.BookCreateInput {
    id: Number;
    title: string;
    description?: string;
}