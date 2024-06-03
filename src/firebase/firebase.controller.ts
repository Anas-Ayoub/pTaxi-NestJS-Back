import { Controller, Get, UseGuards } from '@nestjs/common';
import { FirebaseService } from './firebase.service';
import { AuthGuard } from 'src/guards/firebase-auth.guard';

@Controller('users')
export class FirebaseController {
    constructor(private readonly firebaseService: FirebaseService) { }

    @Get()
    @UseGuards(AuthGuard)
    async getAllUsers() {
        return this.firebaseService.getAllUsers();
    }
}