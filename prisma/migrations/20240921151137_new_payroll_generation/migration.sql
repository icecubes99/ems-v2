-- AlterTable
ALTER TABLE "Timesheet" ADD COLUMN     "forgotClockOut" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isOvertime" BOOLEAN NOT NULL DEFAULT false;
