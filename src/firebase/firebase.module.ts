// src/firebase/firebase.module.ts
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { FirebaseService } from './firebase.service';
import firebaseConfig from '../config/firebase.config';

@Module({
    imports: [ConfigModule.forFeature(firebaseConfig)],
    providers: [FirebaseService],
    exports: [FirebaseService],
})
export class FirebaseModule { }
