import { Injectable, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as admin from 'firebase-admin';

@Injectable()
export class FirebaseService implements OnModuleInit {
    constructor(private readonly configService: ConfigService) { }

    onModuleInit() {
        const firebaseConfig = this.configService.get('firebase');
        admin.initializeApp({
            credential: admin.credential.cert(firebaseConfig),
        });
    }

    getAuth() {
        return admin.auth();
    }

    async getAllUsers(): Promise<string> {
        try {
            const userList = await this.getAuth().listUsers();
            return userList.users[0].uid;
        } catch (error) {
            console.error('Error fetching users:', error);
            throw error;
        }
    }

    // Add other Firebase services (Firestore, Storage, etc.) as needed
}
