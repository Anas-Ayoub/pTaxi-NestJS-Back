import { IsEmail, IsOptional, IsString, IsEnum, IsPhoneNumber } from 'class-validator';
import { UserType } from '@prisma/client';

export class UpdateUserDto {
  @IsOptional()
  @IsEmail()
  email?: string;

  @IsOptional()
  @IsString()
  password_hash?: string;

  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsPhoneNumber()
  phone_number?: string;

  @IsOptional()
  @IsEnum(UserType)
  user_type?: UserType;
}