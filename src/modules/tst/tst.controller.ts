import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { TstService } from './tst.service';
import { AuthGuard } from 'src/guards/firebase-auth.guard';

@UseGuards(AuthGuard)
@Controller('tst')
export class TstController {
    constructor(private readonly driverService: TstService) { }

    @Post()
    create(@Body() data) {
        console.log(data);
        return "ZABNA POSTED";
    }

    @Get()
    findAll() {
        return "YOU GOT ZABNA";
    }
}
