import { Test, TestingModule } from '@nestjs/testing';
import { TstService } from './tst.service';

describe('TstService', () => {
  let service: TstService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [TstService],
    }).compile();

    service = module.get<TstService>(TstService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
