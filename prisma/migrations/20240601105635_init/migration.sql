-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('driver', 'passenger');

-- CreateEnum
CREATE TYPE "DriverStatus" AS ENUM ('available', 'unavailable');

-- CreateEnum
CREATE TYPE "RideStatus" AS ENUM ('requested', 'accepted', 'in_progress', 'completed', 'cancelled');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('credit_card', 'debit_card', 'cash', 'wallet');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('pending', 'completed', 'failed');

-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('pending', 'accepted', 'rejected', 'cancelled');

-- CreateTable
CREATE TABLE "User" (
    "user_id" SERIAL NOT NULL,
    "firebase_auth_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "user_type" "UserType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "Passenger" (
    "passenger_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Passenger_pkey" PRIMARY KEY ("passenger_id")
);

-- CreateTable
CREATE TABLE "Vehicle" (
    "vehicle_id" SERIAL NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "make" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "license_plate" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("vehicle_id")
);

-- CreateTable
CREATE TABLE "Driver" (
    "driver_id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "license_number" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "status" "DriverStatus" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Driver_pkey" PRIMARY KEY ("driver_id")
);

-- CreateTable
CREATE TABLE "Ride" (
    "ride_id" SERIAL NOT NULL,
    "passenger_id" INTEGER NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "start_location_id" INTEGER NOT NULL,
    "end_location_id" INTEGER NOT NULL,
    "status" "RideStatus" NOT NULL,
    "start_time" TIMESTAMP(3),
    "end_time" TIMESTAMP(3),
    "fare" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ride_pkey" PRIMARY KEY ("ride_id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "payment_id" SERIAL NOT NULL,
    "ride_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "payment_method" "PaymentMethod" NOT NULL,
    "payment_status" "PaymentStatus" NOT NULL DEFAULT 'pending',
    "transaction_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("payment_id")
);

-- CreateTable
CREATE TABLE "Feedback" (
    "feedback_id" SERIAL NOT NULL,
    "ride_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("feedback_id")
);

-- CreateTable
CREATE TABLE "Location" (
    "location_id" SERIAL NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "address" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("location_id")
);

-- CreateTable
CREATE TABLE "RideRequest" (
    "request_id" SERIAL NOT NULL,
    "passenger_id" INTEGER NOT NULL,
    "start_location_id" INTEGER NOT NULL,
    "end_location_id" INTEGER NOT NULL,
    "status" "RequestStatus" NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RideRequest_pkey" PRIMARY KEY ("request_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_firebase_auth_id_key" ON "User"("firebase_auth_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_number_key" ON "User"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "Passenger_user_id_key" ON "Passenger"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Vehicle_license_plate_key" ON "Vehicle"("license_plate");

-- CreateIndex
CREATE UNIQUE INDEX "Driver_vehicle_id_key" ON "Driver"("vehicle_id");

-- CreateIndex
CREATE UNIQUE INDEX "Driver_license_number_key" ON "Driver"("license_number");

-- CreateIndex
CREATE UNIQUE INDEX "Driver_user_id_key" ON "Driver"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_transaction_id_key" ON "Payment"("transaction_id");

-- AddForeignKey
ALTER TABLE "Passenger" ADD CONSTRAINT "Passenger_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Driver" ADD CONSTRAINT "Driver_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "Vehicle"("vehicle_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Driver" ADD CONSTRAINT "Driver_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_passenger_id_fkey" FOREIGN KEY ("passenger_id") REFERENCES "Passenger"("passenger_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "Driver"("driver_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_start_location_id_fkey" FOREIGN KEY ("start_location_id") REFERENCES "Location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ride" ADD CONSTRAINT "Ride_end_location_id_fkey" FOREIGN KEY ("end_location_id") REFERENCES "Location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_ride_id_fkey" FOREIGN KEY ("ride_id") REFERENCES "Ride"("ride_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_ride_id_fkey" FOREIGN KEY ("ride_id") REFERENCES "Ride"("ride_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RideRequest" ADD CONSTRAINT "RideRequest_passenger_id_fkey" FOREIGN KEY ("passenger_id") REFERENCES "Passenger"("passenger_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RideRequest" ADD CONSTRAINT "RideRequest_start_location_id_fkey" FOREIGN KEY ("start_location_id") REFERENCES "Location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RideRequest" ADD CONSTRAINT "RideRequest_end_location_id_fkey" FOREIGN KEY ("end_location_id") REFERENCES "Location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;
