-- AlterTable
ALTER TABLE "Timesheet" ADD COLUMN     "clockOutEarly" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "clockOutEarlyMinutes" INTEGER NOT NULL DEFAULT 0;
