import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaService } from './prisma.service';
import { ConfigModule } from '@nestjs/config';
import { FirebaseModule } from './firebase/firebase.module';
import { FirebaseController } from './firebase/firebase.controller';
import { PassengersModule } from './modules/passengers/passengers.module';
import { DriversModule } from './modules/drivers/driver.module';
import { UserModule } from './modules/users/user.module';
import { TstModule } from './modules/tst/tst.module';


@Module({
  imports: [ConfigModule.forRoot(),
    FirebaseModule,
    UserModule,
    PassengersModule, DriversModule, TstModule,],
  controllers: [AppController, FirebaseController,],
  providers: [AppService, PrismaService,],
})
export class AppModule { }
