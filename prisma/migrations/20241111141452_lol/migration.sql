/*
  Warnings:

  - The `status` column on the `Overtimes` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `effectiveDate` on the `SalaryHistory` table. All the data in the column will be lost.
  - You are about to drop the column `salary` on the `SalaryHistory` table. All the data in the column will be lost.
  - You are about to drop the column `hourlyRate` on the `UserSalary` table. All the data in the column will be lost.
  - You are about to drop the column `minuteRate` on the `UserSalary` table. All the data in the column will be lost.
  - Added the required column `documentLink` to the `Leaves` table without a default value. This is not possible if the table is not empty.
  - Added the required column `timeOut` to the `Overtimes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dailyRate` to the `PayrollItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `daysNotWorked` to the `PayrollItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `minutesLate` to the `PayrollItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `minutesNotWorked` to the `PayrollItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `minutesOvertime` to the `PayrollItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `basicSalary` to the `SalaryHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `grossSalary` to the `SalaryHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startDate` to the `SalaryHistory` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "OvertimeStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ArchiveType" AS ENUM ('USER', 'DEPARTMENT', 'DESIGNATION', 'DOCUMENT', 'PAYROLL_ITEM', 'PAYROLL', 'ALLOWANCE');

-- AlterTable
ALTER TABLE "AdditionalEarnings" ADD COLUMN     "payrollItemId" TEXT;

-- AlterTable
ALTER TABLE "Deductions" ADD COLUMN     "payrollItemId" TEXT;

-- AlterTable
ALTER TABLE "Designation" ADD COLUMN     "designationSalary" DOUBLE PRECISION NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Leaves" ADD COLUMN     "documentLink" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Overtimes" ADD COLUMN     "clockIn" TIMESTAMP(3),
ADD COLUMN     "clockOut" TIMESTAMP(3),
ADD COLUMN     "timeOut" TIMESTAMP(3) NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" "OvertimeStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "PayrollItem" ADD COLUMN     "dailyRate" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "daysLeave" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "daysNotWorked" INTEGER NOT NULL,
ADD COLUMN     "earlyClockOutDeductions" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "lateDeductions" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "minutesEarlyOut" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "minutesLate" INTEGER NOT NULL,
ADD COLUMN     "minutesNotWorked" INTEGER NOT NULL,
ADD COLUMN     "minutesOvertime" INTEGER NOT NULL,
ADD COLUMN     "specialDayEarnings" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "specialDayMinutes" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "SalaryHistory" DROP COLUMN "effectiveDate",
DROP COLUMN "salary",
ADD COLUMN     "amountIncreased" DOUBLE PRECISION,
ADD COLUMN     "basicSalary" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "endDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "grossSalary" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "salaryIncreaseEventId" TEXT,
ADD COLUMN     "startDate" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Timesheet" ADD COLUMN     "isAdvanced" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isLeave" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "minutesOvertime" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "payrollItemId" TEXT;

-- AlterTable
ALTER TABLE "UserSalary" DROP COLUMN "hourlyRate",
DROP COLUMN "minuteRate",
ADD COLUMN     "grossSalary" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "WorkingDay" ADD COLUMN     "isRequired" BOOLEAN NOT NULL DEFAULT true;

-- CreateTable
CREATE TABLE "DaysNotWorked" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,
    "payrollItemId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DaysNotWorked_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalaryIncreaseEvent" (
    "id" TEXT NOT NULL,
    "percentage" DOUBLE PRECISION,
    "amount" DOUBLE PRECISION,
    "appliedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "appliedBy" TEXT NOT NULL,
    "isUndone" BOOLEAN NOT NULL DEFAULT false,
    "undoneAt" TIMESTAMP(3),
    "undoneBy" TEXT,

    CONSTRAINT "SalaryIncreaseEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepartmentSalaryIncrease" (
    "departmentId" TEXT NOT NULL,
    "salaryIncreaseEventId" TEXT NOT NULL,

    CONSTRAINT "DepartmentSalaryIncrease_pkey" PRIMARY KEY ("departmentId","salaryIncreaseEventId")
);

-- CreateTable
CREATE TABLE "DesignationSalaryIncrease" (
    "designationId" TEXT NOT NULL,
    "salaryIncreaseEventId" TEXT NOT NULL,

    CONSTRAINT "DesignationSalaryIncrease_pkey" PRIMARY KEY ("designationId","salaryIncreaseEventId")
);

-- CreateTable
CREATE TABLE "GovernmentContribution" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "brackets" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GovernmentContribution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdvanceTimesheet" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "isUndone" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdvanceTimesheet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdvanceTimesheetUsers" (
    "userId" TEXT NOT NULL,
    "advanceTimesheetId" TEXT NOT NULL,

    CONSTRAINT "AdvanceTimesheetUsers_pkey" PRIMARY KEY ("userId","advanceTimesheetId")
);

-- CreateTable
CREATE TABLE "Allowance" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" "Status" NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Allowance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Archive" (
    "id" TEXT NOT NULL,
    "archiveType" "ArchiveType" NOT NULL,
    "entityId" TEXT NOT NULL,
    "entityData" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Archive_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GovernmentContribution_type_key" ON "GovernmentContribution"("type");

-- CreateIndex
CREATE UNIQUE INDEX "Archive_archiveType_entityId_key" ON "Archive"("archiveType", "entityId");

-- AddForeignKey
ALTER TABLE "Timesheet" ADD CONSTRAINT "Timesheet_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "PayrollItem"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "PayrollItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdditionalEarnings" ADD CONSTRAINT "AdditionalEarnings_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "PayrollItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalaryHistory" ADD CONSTRAINT "SalaryHistory_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "SalaryIncreaseEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DaysNotWorked" ADD CONSTRAINT "DaysNotWorked_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DaysNotWorked" ADD CONSTRAINT "DaysNotWorked_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "PayrollItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepartmentSalaryIncrease" ADD CONSTRAINT "DepartmentSalaryIncrease_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepartmentSalaryIncrease" ADD CONSTRAINT "DepartmentSalaryIncrease_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "SalaryIncreaseEvent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DesignationSalaryIncrease" ADD CONSTRAINT "DesignationSalaryIncrease_designationId_fkey" FOREIGN KEY ("designationId") REFERENCES "Designation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DesignationSalaryIncrease" ADD CONSTRAINT "DesignationSalaryIncrease_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "SalaryIncreaseEvent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdvanceTimesheetUsers" ADD CONSTRAINT "AdvanceTimesheetUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdvanceTimesheetUsers" ADD CONSTRAINT "AdvanceTimesheetUsers_advanceTimesheetId_fkey" FOREIGN KEY ("advanceTimesheetId") REFERENCES "AdvanceTimesheet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Allowance" ADD CONSTRAINT "Allowance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
