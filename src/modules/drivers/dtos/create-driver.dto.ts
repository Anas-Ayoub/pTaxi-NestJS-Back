import { IsNotEmpty, IsString, IsInt, IsOptional } from 'class-validator';
import { DriverStatus } from '@prisma/client';

export class CreateDriverDto {
  @IsNotEmpty()
  @IsInt()
  user_id: number;

  @IsInt()
  vehicle_id: number;

  @IsNotEmpty()
  @IsString()
  license_number: string;

  @IsOptional()
  rating?: number;

  @IsNotEmpty()
  status: DriverStatus;
}