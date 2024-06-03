import { IsEmail, IsNotEmpty, IsString, IsEnum, IsPhoneNumber } from 'class-validator';
import { UserType } from '@prisma/client';

export class CreateUserDto {

  @IsString()
  firebase_auth_id; string;

  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  password_hash: string;

  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsPhoneNumber()
  phone_number: string;

  @IsNotEmpty()
  @IsEnum(UserType)
  user_type: UserType;
}