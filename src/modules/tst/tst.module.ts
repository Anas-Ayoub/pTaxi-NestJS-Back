import { Module } from '@nestjs/common';
import { TstService } from './tst.service';
import { TstController } from './tst.controller';
// import { FirebaseService } from 'src/firebase/firebase.service';
// import { ConfigService } from '@nestjs/config';
import { FirebaseModule } from 'src/firebase/firebase.module';
@Module({
  providers: [TstService],
  controllers: [TstController],
  imports: [FirebaseModule],
})
export class TstModule { }
