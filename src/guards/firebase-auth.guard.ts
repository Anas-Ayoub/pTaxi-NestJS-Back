import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { FirebaseService } from 'src/firebase/firebase.service';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(private firebaseService: FirebaseService) { }

    async canActivate(context: ExecutionContext): Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        const authHeader = request.headers.authorization;

        if (!authHeader) {
            throw new UnauthorizedException('Authorization header not found');
        }

        const token = authHeader.split(' ')[1];
        console.log(token);

        try {
            const decodedToken = await this.firebaseService.getAuth().verifyIdToken(token);

            console.log(decodedToken);
            console.log("== REQUEST ==AF");
            console.log(request);

            request.user = decodedToken.uid;
            console.log("== REQUEST ==BF");
            console.log(request);
        } catch (_) {
            console.log("WWWAAAA LA");

            console.log(_)
            return false;
        }
        return true;
    }
}