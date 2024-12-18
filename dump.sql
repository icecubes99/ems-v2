--
-- PostgreSQL database dump
--

-- Dumped from database version 16.5 (Homebrew)
-- Dumped by pg_dump version 16.5 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY "public?"."WorkingDay" DROP CONSTRAINT IF EXISTS "WorkingDay_monthId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."UserSalary" DROP CONSTRAINT IF EXISTS "UserSalary_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."TwoFactorConfirmation" DROP CONSTRAINT IF EXISTS "TwoFactorConfirmation_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Timesheet" DROP CONSTRAINT IF EXISTS "Timesheet_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Timesheet" DROP CONSTRAINT IF EXISTS "Timesheet_payrollItemId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Timesheet" DROP CONSTRAINT IF EXISTS "Timesheet_dayId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."SalaryHistory" DROP CONSTRAINT IF EXISTS "SalaryHistory_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."SalaryHistory" DROP CONSTRAINT IF EXISTS "SalaryHistory_salaryIncreaseEventId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."PayrollItem" DROP CONSTRAINT IF EXISTS "PayrollItem_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."PayrollItem" DROP CONSTRAINT IF EXISTS "PayrollItem_payrollId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Overtimes" DROP CONSTRAINT IF EXISTS "Overtimes_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Leaves" DROP CONSTRAINT IF EXISTS "Leaves_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."GovernmentId" DROP CONSTRAINT IF EXISTS "GovernmentId_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."EmergencyContact" DROP CONSTRAINT IF EXISTS "EmergencyContact_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Documents" DROP CONSTRAINT IF EXISTS "Documents_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Designation" DROP CONSTRAINT IF EXISTS "Designation_designationHeadUserId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Designation" DROP CONSTRAINT IF EXISTS "Designation_departmentId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DesignationSalaryIncrease" DROP CONSTRAINT IF EXISTS "DesignationSalaryIncrease_salaryIncreaseEventId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DesignationSalaryIncrease" DROP CONSTRAINT IF EXISTS "DesignationSalaryIncrease_designationId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Department" DROP CONSTRAINT IF EXISTS "Department_departmentHeadUserId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DepartmentSalaryIncrease" DROP CONSTRAINT IF EXISTS "DepartmentSalaryIncrease_salaryIncreaseEventId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DepartmentSalaryIncrease" DROP CONSTRAINT IF EXISTS "DepartmentSalaryIncrease_departmentId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Deductions" DROP CONSTRAINT IF EXISTS "Deductions_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Deductions" DROP CONSTRAINT IF EXISTS "Deductions_payrollItemId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DaysNotWorked" DROP CONSTRAINT IF EXISTS "DaysNotWorked_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."DaysNotWorked" DROP CONSTRAINT IF EXISTS "DaysNotWorked_payrollItemId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AuditLog" DROP CONSTRAINT IF EXISTS "AuditLog_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AssignDesignation" DROP CONSTRAINT IF EXISTS "AssignDesignation_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AssignDesignation" DROP CONSTRAINT IF EXISTS "AssignDesignation_designationId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Allowance" DROP CONSTRAINT IF EXISTS "Allowance_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdvanceTimesheetUsers" DROP CONSTRAINT IF EXISTS "AdvanceTimesheetUsers_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdvanceTimesheetUsers" DROP CONSTRAINT IF EXISTS "AdvanceTimesheetUsers_advanceTimesheetId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AddressLine" DROP CONSTRAINT IF EXISTS "AddressLine_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdditionalEarnings" DROP CONSTRAINT IF EXISTS "AdditionalEarnings_userId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdditionalEarnings" DROP CONSTRAINT IF EXISTS "AdditionalEarnings_payrollItemId_fkey";
ALTER TABLE IF EXISTS ONLY "public?"."Account" DROP CONSTRAINT IF EXISTS "Account_userId_fkey";
DROP INDEX IF EXISTS "public?"."WorkingMonth_month_year_key";
DROP INDEX IF EXISTS "public?"."WorkingDay_date_monthId_key";
DROP INDEX IF EXISTS "public?"."VerificationToken_token_key";
DROP INDEX IF EXISTS "public?"."VerificationToken_email_token_key";
DROP INDEX IF EXISTS "public?"."User_email_key";
DROP INDEX IF EXISTS "public?"."UserSalary_userId_key";
DROP INDEX IF EXISTS "public?"."TwoFactorToken_token_key";
DROP INDEX IF EXISTS "public?"."TwoFactorToken_email_token_key";
DROP INDEX IF EXISTS "public?"."TwoFactorConfirmation_userId_key";
DROP INDEX IF EXISTS "public?"."Timesheet_userId_dayId_key";
DROP INDEX IF EXISTS "public?"."Payroll_payPeriodStart_payPeriodEnd_key";
DROP INDEX IF EXISTS "public?"."PayrollItem_payrollId_userId_key";
DROP INDEX IF EXISTS "public?"."PasswordResetToken_token_key";
DROP INDEX IF EXISTS "public?"."PasswordResetToken_email_token_key";
DROP INDEX IF EXISTS "public?"."Overtimes_userId_createdAt_key";
DROP INDEX IF EXISTS "public?"."Leaves_userId_startDate_endDate_key";
DROP INDEX IF EXISTS "public?"."Holiday_date_key";
DROP INDEX IF EXISTS "public?"."GovernmentId_userId_key";
DROP INDEX IF EXISTS "public?"."GovernmentContribution_type_key";
DROP INDEX IF EXISTS "public?"."EmergencyContact_userId_key";
DROP INDEX IF EXISTS "public?"."Designation_designationHeadUserId_key";
DROP INDEX IF EXISTS "public?"."Department_departmentHeadUserId_key";
DROP INDEX IF EXISTS "public?"."AssignDesignation_userId_key";
DROP INDEX IF EXISTS "public?"."Archive_archiveType_entityId_key";
DROP INDEX IF EXISTS "public?"."AddressLine_userId_key";
DROP INDEX IF EXISTS "public?"."Account_provider_providerAccountId_key";
ALTER TABLE IF EXISTS ONLY "public?"."WorkingMonth" DROP CONSTRAINT IF EXISTS "WorkingMonth_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."WorkingDay" DROP CONSTRAINT IF EXISTS "WorkingDay_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."VerificationToken" DROP CONSTRAINT IF EXISTS "VerificationToken_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."User" DROP CONSTRAINT IF EXISTS "User_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."UserSalary" DROP CONSTRAINT IF EXISTS "UserSalary_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."TwoFactorToken" DROP CONSTRAINT IF EXISTS "TwoFactorToken_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."TwoFactorConfirmation" DROP CONSTRAINT IF EXISTS "TwoFactorConfirmation_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Timesheet" DROP CONSTRAINT IF EXISTS "Timesheet_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."SalaryIncreaseEvent" DROP CONSTRAINT IF EXISTS "SalaryIncreaseEvent_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."SalaryHistory" DROP CONSTRAINT IF EXISTS "SalaryHistory_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Payroll" DROP CONSTRAINT IF EXISTS "Payroll_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."PayrollItem" DROP CONSTRAINT IF EXISTS "PayrollItem_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."PasswordResetToken" DROP CONSTRAINT IF EXISTS "PasswordResetToken_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Overtimes" DROP CONSTRAINT IF EXISTS "Overtimes_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Leaves" DROP CONSTRAINT IF EXISTS "Leaves_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Holiday" DROP CONSTRAINT IF EXISTS "Holiday_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."GovernmentId" DROP CONSTRAINT IF EXISTS "GovernmentId_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."GovernmentContribution" DROP CONSTRAINT IF EXISTS "GovernmentContribution_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."EmergencyContact" DROP CONSTRAINT IF EXISTS "EmergencyContact_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Documents" DROP CONSTRAINT IF EXISTS "Documents_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Designation" DROP CONSTRAINT IF EXISTS "Designation_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."DesignationSalaryIncrease" DROP CONSTRAINT IF EXISTS "DesignationSalaryIncrease_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Department" DROP CONSTRAINT IF EXISTS "Department_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."DepartmentSalaryIncrease" DROP CONSTRAINT IF EXISTS "DepartmentSalaryIncrease_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Deductions" DROP CONSTRAINT IF EXISTS "Deductions_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."DaysNotWorked" DROP CONSTRAINT IF EXISTS "DaysNotWorked_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AuditLog" DROP CONSTRAINT IF EXISTS "AuditLog_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AssignDesignation" DROP CONSTRAINT IF EXISTS "AssignDesignation_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Archive" DROP CONSTRAINT IF EXISTS "Archive_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Allowance" DROP CONSTRAINT IF EXISTS "Allowance_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdvanceTimesheet" DROP CONSTRAINT IF EXISTS "AdvanceTimesheet_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdvanceTimesheetUsers" DROP CONSTRAINT IF EXISTS "AdvanceTimesheetUsers_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AddressLine" DROP CONSTRAINT IF EXISTS "AddressLine_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."AdditionalEarnings" DROP CONSTRAINT IF EXISTS "AdditionalEarnings_pkey";
ALTER TABLE IF EXISTS ONLY "public?"."Account" DROP CONSTRAINT IF EXISTS "Account_pkey";
DROP TABLE IF EXISTS "public?"."WorkingMonth";
DROP TABLE IF EXISTS "public?"."WorkingDay";
DROP TABLE IF EXISTS "public?"."VerificationToken";
DROP TABLE IF EXISTS "public?"."UserSalary";
DROP TABLE IF EXISTS "public?"."User";
DROP TABLE IF EXISTS "public?"."TwoFactorToken";
DROP TABLE IF EXISTS "public?"."TwoFactorConfirmation";
DROP TABLE IF EXISTS "public?"."Timesheet";
DROP TABLE IF EXISTS "public?"."SalaryIncreaseEvent";
DROP TABLE IF EXISTS "public?"."SalaryHistory";
DROP TABLE IF EXISTS "public?"."PayrollItem";
DROP TABLE IF EXISTS "public?"."Payroll";
DROP TABLE IF EXISTS "public?"."PasswordResetToken";
DROP TABLE IF EXISTS "public?"."Overtimes";
DROP TABLE IF EXISTS "public?"."Leaves";
DROP TABLE IF EXISTS "public?"."Holiday";
DROP TABLE IF EXISTS "public?"."GovernmentId";
DROP TABLE IF EXISTS "public?"."GovernmentContribution";
DROP TABLE IF EXISTS "public?"."EmergencyContact";
DROP TABLE IF EXISTS "public?"."Documents";
DROP TABLE IF EXISTS "public?"."DesignationSalaryIncrease";
DROP TABLE IF EXISTS "public?"."Designation";
DROP TABLE IF EXISTS "public?"."DepartmentSalaryIncrease";
DROP TABLE IF EXISTS "public?"."Department";
DROP TABLE IF EXISTS "public?"."Deductions";
DROP TABLE IF EXISTS "public?"."DaysNotWorked";
DROP TABLE IF EXISTS "public?"."AuditLog";
DROP TABLE IF EXISTS "public?"."AssignDesignation";
DROP TABLE IF EXISTS "public?"."Archive";
DROP TABLE IF EXISTS "public?"."Allowance";
DROP TABLE IF EXISTS "public?"."AdvanceTimesheetUsers";
DROP TABLE IF EXISTS "public?"."AdvanceTimesheet";
DROP TABLE IF EXISTS "public?"."AddressLine";
DROP TABLE IF EXISTS "public?"."AdditionalEarnings";
DROP TABLE IF EXISTS "public?"."Account";
DROP TYPE IF EXISTS "public?"."UserRole";
DROP TYPE IF EXISTS "public?"."Status";
DROP TYPE IF EXISTS "public?"."OvertimeType";
DROP TYPE IF EXISTS "public?"."OvertimeStatus";
DROP TYPE IF EXISTS "public?"."LeaveType";
DROP TYPE IF EXISTS "public?"."LeaveStatus";
DROP TYPE IF EXISTS "public?"."Gender";
DROP TYPE IF EXISTS "public?"."EmployeeType";
DROP TYPE IF EXISTS "public?"."ArchiveType";
DROP SCHEMA IF EXISTS "public?";
--
-- Name: SCHEMA "public?"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public?" IS 'standard public? schema';


--
-- Name: public?; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "public?";


--
-- Name: ArchiveType; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."ArchiveType" AS ENUM (
    'USER',
    'DEPARTMENT',
    'DESIGNATION',
    'DOCUMENT',
    'PAYROLL_ITEM',
    'PAYROLL',
    'ALLOWANCE',
    'TIMESHEET'
);


--
-- Name: EmployeeType; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."EmployeeType" AS ENUM (
    'REGULAR',
    'CONTRACTUAL',
    'PROBATIONARY'
);


--
-- Name: Gender; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


--
-- Name: LeaveStatus; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."LeaveStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


--
-- Name: LeaveType; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."LeaveType" AS ENUM (
    'VACATION',
    'SICK',
    'MATERNITY',
    'INCENTIVE'
);


--
-- Name: OvertimeStatus; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."OvertimeStatus" AS ENUM (
    'PENDING',
    'IN_PROGRESS',
    'COMPLETED',
    'REJECTED'
);


--
-- Name: OvertimeType; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."OvertimeType" AS ENUM (
    'REGULAR',
    'HOLIDAY',
    'MANDATORY'
);


--
-- Name: Status; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."Status" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


--
-- Name: UserRole; Type: TYPE; Schema: public?; Owner: -
--

CREATE TYPE "public?"."UserRole" AS ENUM (
    'ADMIN',
    'USER',
    'SUPERADMIN'
);


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: Account; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Account" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "type" "text" NOT NULL,
    "provider" "text" NOT NULL,
    "providerAccountId" "text" NOT NULL,
    "refresh_token" "text",
    "access_token" "text",
    "expires_at" integer,
    "token_type" "text",
    "scope" "text",
    "id_token" "text",
    "session_state" "text"
);


--
-- Name: AdditionalEarnings; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AdditionalEarnings" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "earningType" "text" NOT NULL,
    "amount" double precision NOT NULL,
    "description" "text" NOT NULL,
    "payrollItemId" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AddressLine; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AddressLine" (
    "id" "text" NOT NULL,
    "street" "text",
    "barangay" "text",
    "city" "text",
    "province" "text",
    "country" "text",
    "zipCode" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp(3) without time zone,
    "userId" "text" NOT NULL
);


--
-- Name: AdvanceTimesheet; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AdvanceTimesheet" (
    "id" "text" NOT NULL,
    "type" "text" NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    "isUndone" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AdvanceTimesheetUsers; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AdvanceTimesheetUsers" (
    "userId" "text" NOT NULL,
    "advanceTimesheetId" "text" NOT NULL
);


--
-- Name: Allowance; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Allowance" (
    "id" "text" NOT NULL,
    "type" "text" NOT NULL,
    "amount" double precision NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    "status" "public?"."Status" NOT NULL,
    "userId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Archive; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Archive" (
    "id" "text" NOT NULL,
    "archiveType" "public?"."ArchiveType" NOT NULL,
    "entityId" "text" NOT NULL,
    "entityData" "jsonb" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: AssignDesignation; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AssignDesignation" (
    "id" "text" NOT NULL,
    "employeeType" "public?"."EmployeeType" NOT NULL,
    "status" "public?"."Status" NOT NULL,
    "designationId" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AuditLog; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."AuditLog" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "action" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: DaysNotWorked; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."DaysNotWorked" (
    "id" "text" NOT NULL,
    "date" timestamp(3) without time zone NOT NULL,
    "userId" "text" NOT NULL,
    "payrollItemId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Deductions; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Deductions" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "deductionType" "text" NOT NULL,
    "amount" double precision NOT NULL,
    "description" "text" NOT NULL,
    "payrollItemId" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Department; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Department" (
    "id" "text" NOT NULL,
    "departmentName" "text" NOT NULL,
    "departmentDescription" "text" NOT NULL,
    "status" "public?"."Status" NOT NULL,
    "departmentHeadUserId" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdBy" "text"
);


--
-- Name: DepartmentSalaryIncrease; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."DepartmentSalaryIncrease" (
    "departmentId" "text" NOT NULL,
    "salaryIncreaseEventId" "text" NOT NULL
);


--
-- Name: Designation; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Designation" (
    "id" "text" NOT NULL,
    "designationName" "text" NOT NULL,
    "designationDescription" "text" NOT NULL,
    "status" "public?"."Status" NOT NULL,
    "departmentId" "text" NOT NULL,
    "designationHeadUserId" "text" NOT NULL,
    "designationSalary" double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdBy" "text"
);


--
-- Name: DesignationSalaryIncrease; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."DesignationSalaryIncrease" (
    "designationId" "text" NOT NULL,
    "salaryIncreaseEventId" "text" NOT NULL
);


--
-- Name: Documents; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Documents" (
    "id" "text" NOT NULL,
    "documentName" "text" NOT NULL,
    "documentType" "text" NOT NULL,
    "documentLink" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" "text" NOT NULL
);


--
-- Name: EmergencyContact; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."EmergencyContact" (
    "id" "text" NOT NULL,
    "firstName" "text" NOT NULL,
    "middleName" "text" NOT NULL,
    "lastName" "text" NOT NULL,
    "relationship" "text" NOT NULL,
    "contactNumber" "text" NOT NULL,
    "emailAddress" "text" NOT NULL,
    "userId" "text" NOT NULL
);


--
-- Name: GovernmentContribution; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."GovernmentContribution" (
    "id" "text" NOT NULL,
    "type" "text" NOT NULL,
    "brackets" "jsonb" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: GovernmentId; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."GovernmentId" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "sssNumber" "text",
    "tinNumber" "text",
    "philHealthNumber" "text",
    "pagIbigNumber" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Holiday; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Holiday" (
    "id" "text" NOT NULL,
    "date" timestamp(3) without time zone NOT NULL,
    "name" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Leaves; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Leaves" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    "leaveStatus" "public?"."LeaveStatus" DEFAULT 'PENDING'::"public?"."LeaveStatus" NOT NULL,
    "reason" "text" NOT NULL,
    "leaveType" "public?"."LeaveType" NOT NULL,
    "documentLink" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Overtimes; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Overtimes" (
    "id" "text" NOT NULL,
    "reason" "text" NOT NULL,
    "status" "public?"."OvertimeStatus" DEFAULT 'PENDING'::"public?"."OvertimeStatus" NOT NULL,
    "overtimeType" "public?"."OvertimeType" NOT NULL,
    "userId" "text" NOT NULL,
    "timeOut" timestamp(3) without time zone NOT NULL,
    "clockIn" timestamp(3) without time zone,
    "clockOut" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: PasswordResetToken; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."PasswordResetToken" (
    "id" "text" NOT NULL,
    "email" "text" NOT NULL,
    "token" "text" NOT NULL,
    "expires" timestamp(3) without time zone NOT NULL
);


--
-- Name: Payroll; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Payroll" (
    "id" "text" NOT NULL,
    "payPeriodStart" timestamp(3) without time zone NOT NULL,
    "payPeriodEnd" timestamp(3) without time zone NOT NULL,
    "payrollStatus" "public?"."LeaveStatus" DEFAULT 'PENDING'::"public?"."LeaveStatus" NOT NULL,
    "totalAmount" double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: PayrollItem; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."PayrollItem" (
    "id" "text" NOT NULL,
    "payrollId" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "basicSalary" double precision NOT NULL,
    "overtimeSalary" double precision DEFAULT 0 NOT NULL,
    "dailyRate" double precision NOT NULL,
    "additionalEarnings" double precision DEFAULT 0 NOT NULL,
    "lateDeductions" double precision DEFAULT 0 NOT NULL,
    "earlyClockOutDeductions" double precision DEFAULT 0 NOT NULL,
    "totalDeductions" double precision DEFAULT 0 NOT NULL,
    "netSalary" double precision NOT NULL,
    "daysWorked" integer NOT NULL,
    "daysNotWorked" integer NOT NULL,
    "daysLeave" integer DEFAULT 0 NOT NULL,
    "minutesWorked" integer NOT NULL,
    "minutesNotWorked" integer NOT NULL,
    "minutesEarlyOut" integer DEFAULT 0 NOT NULL,
    "minutesLate" integer NOT NULL,
    "minutesOvertime" integer NOT NULL,
    "specialDayMinutes" integer DEFAULT 0 NOT NULL,
    "specialDayEarnings" double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: SalaryHistory; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."SalaryHistory" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "basicSalary" double precision NOT NULL,
    "grossSalary" double precision NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "amountIncreased" double precision,
    "salaryIncreaseEventId" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: SalaryIncreaseEvent; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."SalaryIncreaseEvent" (
    "id" "text" NOT NULL,
    "percentage" double precision,
    "amount" double precision,
    "appliedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "appliedBy" "text" NOT NULL,
    "isUndone" boolean DEFAULT false NOT NULL,
    "undoneAt" timestamp(3) without time zone,
    "undoneBy" "text"
);


--
-- Name: Timesheet; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."Timesheet" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "dayId" "text" NOT NULL,
    "clockIn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "clockOut" timestamp(3) without time zone,
    "isLate" boolean DEFAULT false NOT NULL,
    "isOvertime" boolean DEFAULT false NOT NULL,
    "forgotClockOut" boolean DEFAULT false NOT NULL,
    "clockOutEarly" boolean DEFAULT false NOT NULL,
    "isLeave" boolean DEFAULT false NOT NULL,
    "isAdvanced" boolean DEFAULT false NOT NULL,
    "clockOutEarlyMinutes" integer DEFAULT 0 NOT NULL,
    "minutesOvertime" integer DEFAULT 0 NOT NULL,
    "minutesLate" integer DEFAULT 0 NOT NULL,
    "payrollItemId" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: TwoFactorConfirmation; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."TwoFactorConfirmation" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL
);


--
-- Name: TwoFactorToken; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."TwoFactorToken" (
    "id" "text" NOT NULL,
    "email" "text" NOT NULL,
    "token" "text" NOT NULL,
    "expires" timestamp(3) without time zone NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."User" (
    "id" "text" NOT NULL,
    "firstName" "text",
    "middleName" "text",
    "lastName" "text",
    "gender" "public?"."Gender",
    "dateOfBirth" timestamp(3) without time zone,
    "jobTitle" "text",
    "email" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp(3) without time zone,
    "lastLogin" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "vacationDays" integer DEFAULT 5,
    "incentiveDays" integer DEFAULT 5,
    "emailVerified" timestamp(3) without time zone,
    "image" "text",
    "password" "text",
    "role" "public?"."UserRole" DEFAULT 'USER'::"public?"."UserRole" NOT NULL,
    "isTwoFactorEnabled" boolean DEFAULT false NOT NULL,
    "twoFactorConfirmationId" "text",
    "isArchived" boolean DEFAULT false NOT NULL
);


--
-- Name: UserSalary; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."UserSalary" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "basicSalary" double precision NOT NULL,
    "grossSalary" double precision,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: VerificationToken; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."VerificationToken" (
    "id" "text" NOT NULL,
    "email" "text" NOT NULL,
    "token" "text" NOT NULL,
    "expires" timestamp(3) without time zone NOT NULL
);


--
-- Name: WorkingDay; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."WorkingDay" (
    "id" "text" NOT NULL,
    "date" timestamp(3) without time zone NOT NULL,
    "password" "text" NOT NULL,
    "monthId" "text" NOT NULL,
    "isRequired" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: WorkingMonth; Type: TABLE; Schema: public?; Owner: -
--

CREATE TABLE "public?"."WorkingMonth" (
    "id" "text" NOT NULL,
    "month" integer NOT NULL,
    "year" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Data for Name: Account; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Account" ("id", "userId", "type", "provider", "providerAccountId", "refresh_token", "access_token", "expires_at", "token_type", "scope", "id_token", "session_state") FROM stdin;
\.


--
-- Data for Name: AdditionalEarnings; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AdditionalEarnings" ("id", "userId", "earningType", "amount", "description", "payrollItemId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AddressLine; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AddressLine" ("id", "street", "barangay", "city", "province", "country", "zipCode", "createdAt", "updatedAt", "userId") FROM stdin;
\.


--
-- Data for Name: AdvanceTimesheet; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AdvanceTimesheet" ("id", "type", "startDate", "endDate", "isUndone", "createdAt", "updatedAt") FROM stdin;
cm3slj4q000pj98xyl39tuj44	Onsite	2024-10-31 00:00:00	2024-12-01 00:00:00	f	2024-11-22 10:26:14.566	2024-11-22 10:26:14.566
cm3srcbhr00sd98xymflwpakf	Onsite	2024-12-02 00:00:00	2024-12-07 00:00:00	t	2024-11-22 13:08:54.446	2024-11-22 13:26:52.155
cm3xpc9yn001h7jwwd615x1bn	Onsite	2024-09-30 00:00:00	2024-12-01 00:00:00	f	2024-11-26 00:11:44.108	2024-11-26 00:11:44.108
cm3xpfpmj008x7jww1q4lr7sf	Onsite	2024-10-01 00:00:00	2024-11-22 00:00:00	f	2024-11-26 00:14:24.378	2024-11-26 00:14:24.378
cm3xw9y3400s67jww55cui4xv	Onsite	2024-09-01 00:00:00	2024-11-29 00:00:00	f	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
\.


--
-- Data for Name: AdvanceTimesheetUsers; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AdvanceTimesheetUsers" ("userId", "advanceTimesheetId") FROM stdin;
cm3sd6n7y000h98xyfpmb6any	cm3slj4q000pj98xyl39tuj44
emman	cm3slj4q000pj98xyl39tuj44
emman	cm3srcbhr00sd98xymflwpakf
cm3sd6n7y000h98xyfpmb6any	cm3srcbhr00sd98xymflwpakf
cm3sd5sob000698xytgsayvvu	cm3srcbhr00sd98xymflwpakf
cm3sd6n7y000h98xyfpmb6any	cm3xpc9yn001h7jwwd615x1bn
cm3sd5sob000698xytgsayvvu	cm3xpc9yn001h7jwwd615x1bn
emman	cm3xpc9yn001h7jwwd615x1bn
emman	cm3xpfpmj008x7jww1q4lr7sf
cm3sd5sob000698xytgsayvvu	cm3xpfpmj008x7jww1q4lr7sf
cm3sd6n7y000h98xyfpmb6any	cm3xpfpmj008x7jww1q4lr7sf
cm3xvft2k00nb7jwwzijna876	cm3xw9y3400s67jww55cui4xv
cm3xvi9qr00nm7jwwmi7v4fru	cm3xw9y3400s67jww55cui4xv
cm3xvamu600mp7jwwmgb1kf5e	cm3xw9y3400s67jww55cui4xv
cm3xv6vyj00me7jww8fatnd46	cm3xw9y3400s67jww55cui4xv
cm3xv2tuq00ls7jwwsxzu6lcp	cm3xw9y3400s67jww55cui4xv
cm3xvd52v00n07jwwu9txe547	cm3xw9y3400s67jww55cui4xv
cm3xv4w6000m37jww5tkffps0	cm3xw9y3400s67jww55cui4xv
cm3xuz9oj00lh7jww07cy3cil	cm3xw9y3400s67jww55cui4xv
cm3xusu1p00l67jwwmm29up9j	cm3xw9y3400s67jww55cui4xv
cm3xufw6p00k97jww8n9qq7fq	cm3xw9y3400s67jww55cui4xv
cm3xuoj8d00kv7jwwop9hwrrk	cm3xw9y3400s67jww55cui4xv
cm3xud7bl00jy7jww9qzfi51c	cm3xw9y3400s67jww55cui4xv
cm3xuj38h00kk7jwwnwywtik2	cm3xw9y3400s67jww55cui4xv
cm3xu8bx700jn7jwwlfh8k68g	cm3xw9y3400s67jww55cui4xv
\.


--
-- Data for Name: Allowance; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Allowance" ("id", "type", "amount", "startDate", "endDate", "status", "userId", "createdAt", "updatedAt") FROM stdin;
cm3ww1e0x000a7jww4p2rgppe	Educational Allowance	5000	2024-11-26 00:00:00	2024-11-30 00:00:00	ACTIVE	cm3sd6n7y000h98xyfpmb6any	2024-11-25 10:31:27.297	2024-11-25 10:32:05.273
\.


--
-- Data for Name: Archive; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Archive" ("id", "archiveType", "entityId", "entityData", "createdAt") FROM stdin;
cm3xpm5se00ff7jwwjcgsmhuz	PAYROLL	cm3xpikqe00fc7jwwmoeug8av	{"id": "cm3xpikqe00fc7jwwmoeug8av", "createdAt": "2024-11-26T00:16:38.007Z", "updatedAt": "2024-11-26T00:16:38.032Z", "totalAmount": 0, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 00:19:25.263
cm3xpqps200fs7jwwlnvp8go8	PAYROLL	cm3xpm71h00fj7jww5bgnhcum	{"id": "cm3xpm71h00fj7jww5bgnhcum", "createdAt": "2024-11-26T00:19:26.886Z", "updatedAt": "2024-11-26T00:19:26.904Z", "totalAmount": 0, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 00:22:57.794
cm3xpr8n300fw7jwwrn8a2i4t	PAYROLL	cm3wqlsmx0010ryyffjzruayq	{"id": "cm3wqlsmx0010ryyffjzruayq", "createdAt": "2024-11-25T07:59:21.657Z", "updatedAt": "2024-11-25T11:43:58.981Z", "totalAmount": -1420, "payPeriodEnd": "2024-11-30T15:59:59.999Z", "payrollItems": [{"id": "cm3wruj5g0015ryyf3ehfxpgs", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "dailyRate": 550, "daysLeave": 0, "netSalary": -870, "payrollId": "cm3wqlsmx0010ryyffjzruayq", "updatedAt": "2024-11-25T08:34:08.882Z", "daysWorked": 0, "deductions": [{"id": "cm3wruj5y0017ryyfjhyd64x6", "amount": 495, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj5y0019ryyf6ex9sbds", "amount": 275, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj5y001bryyfzs4lrg1t", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj5y001dryyf83odc6g1", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}], "timesheets": [], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [{"id": "cm3wruj69001eryyf31z458tu", "date": "2024-11-03T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001fryyfn3njjgep", "date": "2024-11-04T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001gryyfiu7exrdg", "date": "2024-11-05T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001hryyfvr22zm8d", "date": "2024-11-06T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001iryyf6i2jmkcf", "date": "2024-11-07T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001jryyf915klhrz", "date": "2024-11-10T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001kryyfdqoksvp8", "date": "2024-11-11T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001lryyf5tyrft0o", "date": "2024-11-12T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001mryyf3f0il6vy", "date": "2024-11-13T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001nryyfxo7kfmg2", "date": "2024-11-14T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001oryyfiiqth1uw", "date": "2024-11-17T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001pryyfzm6jd1ur", "date": "2024-11-18T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001qryyfdcsk4fns", "date": "2024-11-19T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001rryyf3glwpfvr", "date": "2024-11-20T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001sryyfvwi64id2", "date": "2024-11-21T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001tryyfy2z4gbf2", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001uryyfd27izap9", "date": "2024-11-25T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001vryyfgr7lhb49", "date": "2024-11-26T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001wryyfyyi9psb7", "date": "2024-11-27T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001xryyfncx3oqcz", "date": "2024-11-28T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}], "minutesWorked": 0, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 11870, "minutesNotWorked": 12000, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [{"id": "cm3wruj69001eryyf31z458tu", "date": "2024-11-03T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001fryyfn3njjgep", "date": "2024-11-04T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001gryyfiu7exrdg", "date": "2024-11-05T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001hryyfvr22zm8d", "date": "2024-11-06T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001iryyf6i2jmkcf", "date": "2024-11-07T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001jryyf915klhrz", "date": "2024-11-10T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001kryyfdqoksvp8", "date": "2024-11-11T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001lryyf5tyrft0o", "date": "2024-11-12T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001mryyf3f0il6vy", "date": "2024-11-13T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001nryyfxo7kfmg2", "date": "2024-11-14T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001oryyfiiqth1uw", "date": "2024-11-17T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001pryyfzm6jd1ur", "date": "2024-11-18T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001qryyfdcsk4fns", "date": "2024-11-19T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001rryyf3glwpfvr", "date": "2024-11-20T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001sryyfvwi64id2", "date": "2024-11-21T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001tryyfy2z4gbf2", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001uryyfd27izap9", "date": "2024-11-25T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001vryyfgr7lhb49", "date": "2024-11-26T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001wryyfyyi9psb7", "date": "2024-11-27T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}, {"id": "cm3wruj69001xryyfncx3oqcz", "date": "2024-11-28T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T08:34:08.882Z", "updatedAt": "2024-11-25T08:34:08.882Z", "payrollItemId": "cm3wruj5g0015ryyf3ehfxpgs"}], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3wymnt2000l7jww2m3q7205", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "dailyRate": 250, "daysLeave": 0, "netSalary": -550, "payrollId": "cm3wqlsmx0010ryyffjzruayq", "updatedAt": "2024-11-25T11:43:58.981Z", "daysWorked": 0, "deductions": [{"id": "cm3wymntr000n7jwwzwf673d9", "amount": 225, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymntr000p7jwwhdihzlxv", "amount": 225, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymntr000r7jwwx25al8h8", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymntr000t7jwwf18cjvgo", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}], "timesheets": [], "basicSalary": 5000, "minutesLate": 0, "daysNotWorked": [{"id": "cm3wymnu1000u7jwwzagvko4i", "date": "2024-11-03T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000v7jwwn28u7iq4", "date": "2024-11-04T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000w7jww7rpneted", "date": "2024-11-05T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000x7jwwin76wjwf", "date": "2024-11-06T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000y7jwwr42u65en", "date": "2024-11-07T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000z7jwwqz6dvkpx", "date": "2024-11-10T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100107jww5sakzrmd", "date": "2024-11-11T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100117jwwxqzgbxj9", "date": "2024-11-12T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100127jwwaim6p9r1", "date": "2024-11-13T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100137jwwpq4qvoih", "date": "2024-11-14T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100147jwwtn9dg6a9", "date": "2024-11-17T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100157jwwghdtlfg4", "date": "2024-11-18T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100167jww29r39vqq", "date": "2024-11-19T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100177jwwgksywf1d", "date": "2024-11-20T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100187jwww9ezrd2z", "date": "2024-11-21T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100197jwwdujjlep0", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001a7jwwzodgo7n0", "date": "2024-11-25T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001b7jwwgibb6xma", "date": "2024-11-26T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001c7jwwi5z7p7bd", "date": "2024-11-27T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001d7jwwdmrh8lwu", "date": "2024-11-28T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}], "minutesWorked": 0, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 5550, "minutesNotWorked": 12000, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [{"id": "cm3wymnu1000u7jwwzagvko4i", "date": "2024-11-03T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000v7jwwn28u7iq4", "date": "2024-11-04T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000w7jww7rpneted", "date": "2024-11-05T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000x7jwwin76wjwf", "date": "2024-11-06T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000y7jwwr42u65en", "date": "2024-11-07T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1000z7jwwqz6dvkpx", "date": "2024-11-10T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100107jww5sakzrmd", "date": "2024-11-11T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100117jwwxqzgbxj9", "date": "2024-11-12T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100127jwwaim6p9r1", "date": "2024-11-13T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100137jwwpq4qvoih", "date": "2024-11-14T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100147jwwtn9dg6a9", "date": "2024-11-17T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100157jwwghdtlfg4", "date": "2024-11-18T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100167jww29r39vqq", "date": "2024-11-19T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100177jwwgksywf1d", "date": "2024-11-20T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100187jwww9ezrd2z", "date": "2024-11-21T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu100197jwwdujjlep0", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001a7jwwzodgo7n0", "date": "2024-11-25T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001b7jwwgibb6xma", "date": "2024-11-26T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001c7jwwi5z7p7bd", "date": "2024-11-27T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}, {"id": "cm3wymnu1001d7jwwdmrh8lwu", "date": "2024-11-28T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-25T11:43:58.981Z", "updatedAt": "2024-11-25T11:43:58.981Z", "payrollItemId": "cm3wymnt2000l7jww2m3q7205"}], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}], "payrollStatus": "PENDING", "payPeriodStart": "2024-10-31T16:00:00.000Z"}	2024-11-26 00:23:22.239
cm3xpvr2z00h57jwwyp9kt7xd	PAYROLL	cm3xpr9xc00g07jwwi5ist7mv	{"id": "cm3xpr9xc00g07jwwi5ist7mv", "createdAt": "2024-11-26T00:23:23.905Z", "updatedAt": "2024-11-26T00:25:57.202Z", "totalAmount": 27380, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [{"id": "cm3xpuk6i00g57jwwpmqdwkr0", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9120, "payrollId": "cm3xpr9xc00g07jwwi5ist7mv", "updatedAt": "2024-11-26T00:25:57.160Z", "daysWorked": 10, "deductions": [{"id": "cm3xpuk6k00g77jww3lwo5p3b", "amount": 495, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}, {"id": "cm3xpuk6k00g97jwwzzhrx8hm", "amount": 275, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}, {"id": "cm3xpuk6k00gb7jwwuljn2xuk", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}, {"id": "cm3xpuk6k00gd7jwwb24nuebj", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}, {"id": "cm3wx7w36000i7jwwcija1buc", "amount": 10, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T11:04:30.258Z", "updatedAt": "2024-11-26T00:25:57.160Z", "description": "test", "deductionType": "Disbursement", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}], "timesheets": [{"id": "cm3xpfpof00aj7jwwwa9r51ft", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoh00al7jwwgvzgnyvr", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoi00an7jwwuvnnydgu", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpok00ap7jwwczgbecof", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpom00ar7jww1uefyhm9", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpop00at7jww8brogkji", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpor00av7jww46tfhoag", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpou00ax7jwwpj4ncd8c", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpow00az7jwwvu3j6qq0", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpox00b17jww5mgwel14", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.160Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [{"id": "cm3xpuk6v00ge7jwwl9l2gnvw", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1880, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [{"id": "cm3xpuk6v00ge7jwwl9l2gnvw", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:25:57.160Z", "updatedAt": "2024-11-26T00:25:57.160Z", "payrollItemId": "cm3xpuk6i00g57jwwpmqdwkr0"}], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xpuk7800gh7jwwjfm0o5sy", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xpr9xc00g07jwwi5ist7mv", "updatedAt": "2024-11-26T00:25:57.188Z", "daysWorked": 10, "deductions": [{"id": "cm3xpuk7900gj7jww5s2pkkox", "amount": 495, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}, {"id": "cm3xpuk7900gl7jwwszq49ola", "amount": 275, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}, {"id": "cm3xpuk7900gn7jwwnayd1ev4", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}, {"id": "cm3xpuk7900gp7jww5djavqmw", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}], "timesheets": [{"id": "cm3xpfpqc00cn7jwwlajsp8yc", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqe00cp7jww66rzeqw5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqf00cr7jww6murwxba", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqh00ct7jwwjrena8n2", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqi00cv7jwwthur880t", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpql00cx7jwwrsiljob9", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqm00cz7jwwdilqrcix", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqo00d17jwwnd4aqize", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqp00d37jww1pknk7qb", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqr00d57jwwdfmgenuc", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.188Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [{"id": "cm3xpuk7c00gq7jwwc2s3go8f", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [{"id": "cm3xpuk7c00gq7jwwc2s3go8f", "date": "2024-11-24T16:00:00.000Z", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:25:57.188Z", "updatedAt": "2024-11-26T00:25:57.188Z", "payrollItemId": "cm3xpuk7800gh7jwwjfm0o5sy"}], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xpuk7m00gt7jww4rakxfdq", "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xpr9xc00g07jwwi5ist7mv", "updatedAt": "2024-11-26T00:25:57.202Z", "daysWorked": 10, "deductions": [{"id": "cm3xpuk7n00gv7jwwfmvpr242", "amount": 495, "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}, {"id": "cm3xpuk7n00gx7jww5ccmgdn2", "amount": 275, "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}, {"id": "cm3xpuk7n00gz7jwworh8qk2b", "amount": 100, "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}, {"id": "cm3xpuk7n00h17jww4hr9lo9j", "amount": 0, "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}], "timesheets": [{"id": "cm3xpfps700er7jwwguzzw1gu", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "emman", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps800et7jwws2xostwx", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "emman", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsa00ev7jwweulz8osz", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "emman", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsc00ex7jwwjagdg1xu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "emman", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsd00ez7jwwex8fhom3", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "emman", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsf00f17jwwk4nr18h2", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "emman", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsh00f37jwwbgpvfjfb", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "emman", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsi00f57jwwfc02oppe", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "emman", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsk00f77jwww0udziym", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "emman", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsl00f97jwwd3zfiez9", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "emman", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:25:57.202Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [{"id": "cm3xpuk7r00h27jwwp1yv4494", "date": "2024-11-24T16:00:00.000Z", "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [{"id": "cm3xpuk7r00h27jwwp1yv4494", "date": "2024-11-24T16:00:00.000Z", "userId": "emman", "createdAt": "2024-11-26T00:25:57.202Z", "updatedAt": "2024-11-26T00:25:57.202Z", "payrollItemId": "cm3xpuk7m00gt7jww4rakxfdq"}], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 00:26:52.763
cm3xpzsor00i97jwwduv1sbq8	PAYROLL_ITEM	cm3xpz1t500hc7jwwr9xzzoj1	{"id": "cm3xpz1t500hc7jwwr9xzzoj1", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:29:26.633Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9120, "payrollId": "cm3xpz1sj00h97jww7q2618b9", "updatedAt": "2024-11-26T00:29:26.633Z", "daysWorked": 10, "deductions": [{"id": "cm3xpz1t800he7jww2albyxkn", "amount": 495, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:29:26.633Z", "updatedAt": "2024-11-26T00:29:26.633Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1"}, {"id": "cm3xpz1t800hg7jww13hfj3be", "amount": 275, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:29:26.633Z", "updatedAt": "2024-11-26T00:29:26.633Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1"}, {"id": "cm3xpz1t800hi7jwwqds465eu", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:29:26.633Z", "updatedAt": "2024-11-26T00:29:26.633Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1"}, {"id": "cm3xpz1t800hk7jwwvq7cho9h", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T00:29:26.633Z", "updatedAt": "2024-11-26T00:29:26.633Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1"}, {"id": "cm3wx7w36000i7jwwcija1buc", "amount": 10, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T11:04:30.258Z", "updatedAt": "2024-11-26T00:29:26.633Z", "description": "test", "deductionType": "Disbursement", "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1"}], "timesheets": [{"id": "cm3xpfpof00aj7jwwwa9r51ft", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoh00al7jwwgvzgnyvr", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoi00an7jwwuvnnydgu", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpok00ap7jwwczgbecof", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpom00ar7jww1uefyhm9", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpop00at7jww8brogkji", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpor00av7jww46tfhoag", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpou00ax7jwwpj4ncd8c", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpow00az7jwwvu3j6qq0", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpox00b17jww5mgwel14", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.633Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1t500hc7jwwr9xzzoj1", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1880, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}	2024-11-26 00:30:01.467
cm3xpzw1d00ic7jwwnrepdet2	PAYROLL_ITEM	cm3xpz1tj00hn7jwwuwxj4qqh	{"id": "cm3xpz1tj00hn7jwwuwxj4qqh", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:29:26.647Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xpz1sj00h97jww7q2618b9", "updatedAt": "2024-11-26T00:29:26.647Z", "daysWorked": 10, "deductions": [{"id": "cm3xpz1tk00hp7jwwn8jqfzb8", "amount": 495, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:29:26.647Z", "updatedAt": "2024-11-26T00:29:26.647Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh"}, {"id": "cm3xpz1tk00hr7jww8yxl8w8m", "amount": 275, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:29:26.647Z", "updatedAt": "2024-11-26T00:29:26.647Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh"}, {"id": "cm3xpz1tk00ht7jwwry0xk73x", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:29:26.647Z", "updatedAt": "2024-11-26T00:29:26.647Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh"}, {"id": "cm3xpz1tk00hv7jwwbhicthsb", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T00:29:26.647Z", "updatedAt": "2024-11-26T00:29:26.647Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh"}], "timesheets": [{"id": "cm3xpfpqc00cn7jwwlajsp8yc", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqe00cp7jww66rzeqw5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqf00cr7jww6murwxba", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqh00ct7jwwjrena8n2", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqi00cv7jwwthur880t", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpql00cx7jwwrsiljob9", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqm00cz7jwwdilqrcix", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqo00d17jwwnd4aqize", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqp00d37jww1pknk7qb", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqr00d57jwwdfmgenuc", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.647Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tj00hn7jwwuwxj4qqh", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}	2024-11-26 00:30:05.809
cm3xpzywp00if7jwwxwfvs2oy	PAYROLL_ITEM	cm3xpz1tq00hy7jwwchaa574r	{"id": "cm3xpz1tq00hy7jwwchaa574r", "userId": "emman", "createdAt": "2024-11-26T00:29:26.654Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xpz1sj00h97jww7q2618b9", "updatedAt": "2024-11-26T00:29:26.654Z", "daysWorked": 10, "deductions": [{"id": "cm3xpz1tr00i07jwwn83b5wnh", "amount": 495, "userId": "emman", "createdAt": "2024-11-26T00:29:26.654Z", "updatedAt": "2024-11-26T00:29:26.654Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r"}, {"id": "cm3xpz1tr00i27jww4bqmxy4v", "amount": 275, "userId": "emman", "createdAt": "2024-11-26T00:29:26.654Z", "updatedAt": "2024-11-26T00:29:26.654Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r"}, {"id": "cm3xpz1tr00i47jwwvyseya9u", "amount": 100, "userId": "emman", "createdAt": "2024-11-26T00:29:26.654Z", "updatedAt": "2024-11-26T00:29:26.654Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r"}, {"id": "cm3xpz1tr00i67jww5i0h0sph", "amount": 0, "userId": "emman", "createdAt": "2024-11-26T00:29:26.654Z", "updatedAt": "2024-11-26T00:29:26.654Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r"}], "timesheets": [{"id": "cm3xpfps700er7jwwguzzw1gu", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "emman", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps800et7jwws2xostwx", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "emman", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsa00ev7jwweulz8osz", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "emman", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsc00ex7jwwjagdg1xu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "emman", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsd00ez7jwwex8fhom3", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "emman", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsf00f17jwwk4nr18h2", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "emman", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsh00f37jwwbgpvfjfb", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "emman", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsi00f57jwwfc02oppe", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "emman", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsk00f77jwww0udziym", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "emman", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsl00f97jwwd3zfiez9", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "emman", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T00:29:26.654Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xpz1tq00hy7jwwchaa574r", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}	2024-11-26 00:30:09.53
cm3xrb5vz00ii7jww6cku2a7p	PAYROLL	cm3xpz1sj00h97jww7q2618b9	{"id": "cm3xpz1sj00h97jww7q2618b9", "createdAt": "2024-11-26T00:29:26.612Z", "updatedAt": "2024-11-26T00:30:09.537Z", "totalAmount": 0, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 01:06:51.408
cm3xxrlv202mp7jwwbe2f8uae	PAYROLL	cm3xrb70q00im7jwwpycu06ro	{"id": "cm3xrb70q00im7jwwpycu06ro", "createdAt": "2024-11-26T01:06:52.874Z", "updatedAt": "2024-11-26T01:06:52.949Z", "totalAmount": 27380, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [{"id": "cm3xrb71h00ip7jww3xdrn4b8", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T01:06:52.900Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9120, "payrollId": "cm3xrb70q00im7jwwpycu06ro", "updatedAt": "2024-11-26T01:06:52.900Z", "daysWorked": 10, "deductions": [{"id": "cm3xrb71k00ir7jwwcxtdscti", "amount": 495, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T01:06:52.900Z", "updatedAt": "2024-11-26T01:06:52.900Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8"}, {"id": "cm3xrb71k00it7jwwx6x48pev", "amount": 275, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T01:06:52.900Z", "updatedAt": "2024-11-26T01:06:52.900Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8"}, {"id": "cm3xrb71k00iv7jwwzxxx5faf", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T01:06:52.900Z", "updatedAt": "2024-11-26T01:06:52.900Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8"}, {"id": "cm3xrb71k00ix7jwwbzrntfgd", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T01:06:52.900Z", "updatedAt": "2024-11-26T01:06:52.900Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8"}, {"id": "cm3wx7w36000i7jwwcija1buc", "amount": 10, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T11:04:30.258Z", "updatedAt": "2024-11-26T01:06:52.900Z", "description": "test", "deductionType": "Disbursement", "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8"}], "timesheets": [{"id": "cm3xpfpof00aj7jwwwa9r51ft", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoh00al7jwwgvzgnyvr", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoi00an7jwwuvnnydgu", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpok00ap7jwwczgbecof", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpom00ar7jww1uefyhm9", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpop00at7jww8brogkji", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpor00av7jww46tfhoag", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpou00ax7jwwpj4ncd8c", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpow00az7jwwvu3j6qq0", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpox00b17jww5mgwel14", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.900Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71h00ip7jww3xdrn4b8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1880, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xrb71w00j07jwwr4ibtamq", "userId": "emman", "createdAt": "2024-11-26T01:06:52.916Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xrb70q00im7jwwpycu06ro", "updatedAt": "2024-11-26T01:06:52.916Z", "daysWorked": 10, "deductions": [{"id": "cm3xrb72b00j27jwwzs6x6kud", "amount": 495, "userId": "emman", "createdAt": "2024-11-26T01:06:52.916Z", "updatedAt": "2024-11-26T01:06:52.916Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq"}, {"id": "cm3xrb72b00j47jwwhg81t5eu", "amount": 275, "userId": "emman", "createdAt": "2024-11-26T01:06:52.916Z", "updatedAt": "2024-11-26T01:06:52.916Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq"}, {"id": "cm3xrb72c00j67jwwdx3roub9", "amount": 100, "userId": "emman", "createdAt": "2024-11-26T01:06:52.916Z", "updatedAt": "2024-11-26T01:06:52.916Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq"}, {"id": "cm3xrb72c00j87jww6xya00i5", "amount": 0, "userId": "emman", "createdAt": "2024-11-26T01:06:52.916Z", "updatedAt": "2024-11-26T01:06:52.916Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq"}], "timesheets": [{"id": "cm3xpfps700er7jwwguzzw1gu", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "emman", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps800et7jwws2xostwx", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "emman", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsa00ev7jwweulz8osz", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "emman", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsc00ex7jwwjagdg1xu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "emman", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsd00ez7jwwex8fhom3", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "emman", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsf00f17jwwk4nr18h2", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "emman", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsh00f37jwwbgpvfjfb", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "emman", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsi00f57jwwfc02oppe", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "emman", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsk00f77jwww0udziym", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "emman", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsl00f97jwwd3zfiez9", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "emman", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.916Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb71w00j07jwwr4ibtamq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xrb72l00jb7jwwcrfp1nhd", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T01:06:52.941Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xrb70q00im7jwwpycu06ro", "updatedAt": "2024-11-26T01:06:52.941Z", "daysWorked": 10, "deductions": [{"id": "cm3xrb72n00jd7jwwrfrxemb9", "amount": 495, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T01:06:52.941Z", "updatedAt": "2024-11-26T01:06:52.941Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd"}, {"id": "cm3xrb72n00jf7jww4bqwzlba", "amount": 275, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T01:06:52.941Z", "updatedAt": "2024-11-26T01:06:52.941Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd"}, {"id": "cm3xrb72n00jh7jwwklpy1jbz", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T01:06:52.941Z", "updatedAt": "2024-11-26T01:06:52.941Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd"}, {"id": "cm3xrb72n00jj7jww4m88qeqa", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T01:06:52.941Z", "updatedAt": "2024-11-26T01:06:52.941Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd"}], "timesheets": [{"id": "cm3xpfpqc00cn7jwwlajsp8yc", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqe00cp7jww66rzeqw5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqf00cr7jww6murwxba", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqh00ct7jwwjrena8n2", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqi00cv7jwwthur880t", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpql00cx7jwwrsiljob9", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqm00cz7jwwdilqrcix", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqo00d17jwwnd4aqize", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqp00d37jww1pknk7qb", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqr00d57jwwdfmgenuc", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T01:06:52.941Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xrb72l00jb7jwwcrfp1nhd", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 04:07:36.303
cm3y0d4z202rk7jww3g0sweo9	PAYROLL	cm3xxscdy02mt7jwwqgvzhyj3	{"id": "cm3xxscdy02mt7jwwqgvzhyj3", "createdAt": "2024-11-26T04:08:10.678Z", "updatedAt": "2024-11-26T04:08:10.875Z", "totalAmount": 326375.165, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [{"id": "cm3xxscet02mw7jwwd4ajusd7", "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T04:08:10.709Z", "dailyRate": 2818.181818181818, "daysLeave": 0, "netSalary": 27474.9515, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.709Z", "daysWorked": 11, "deductions": [{"id": "cm3xxscex02my7jwwuermk1eq", "amount": 1125, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T04:08:10.709Z", "updatedAt": "2024-11-26T04:08:10.709Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7"}, {"id": "cm3xxscex02n07jww3uo60f6b", "amount": 775, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T04:08:10.709Z", "updatedAt": "2024-11-26T04:08:10.709Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7"}, {"id": "cm3xxscex02n27jwwpl8jjgmj", "amount": 100, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T04:08:10.709Z", "updatedAt": "2024-11-26T04:08:10.709Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7"}, {"id": "cm3xxscex02n47jww5adkhgwc", "amount": 1525.0485, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T04:08:10.709Z", "updatedAt": "2024-11-26T04:08:10.709Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7"}], "timesheets": [{"id": "cm3xw9ylx01967jwwxdrolzoq", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ylz01987jwws9mrv0kf", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym0019a7jwwjeguwkaa", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym3019c7jwwil7961g1", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym4019e7jwwxrxns977", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yml019g7jwwlv02pfab", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymm019i7jwwmybiurg3", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymo019k7jwwz5zaz234", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymq019m7jwwrtqw8m9c", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymt019o7jwwg4exwua0", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymw019q7jwwk5kaea6d", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.709Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscet02mw7jwwd4ajusd7", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 31000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 3525.0485, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxscft02n77jwwwhk8d5qq", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T04:08:10.744Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.744Z", "daysWorked": 10, "deductions": [{"id": "cm3xxscfv02n97jww5p3zpx4i", "amount": 495, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T04:08:10.744Z", "updatedAt": "2024-11-26T04:08:10.744Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq"}, {"id": "cm3xxscfv02nb7jwwyl3t33ml", "amount": 275, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T04:08:10.744Z", "updatedAt": "2024-11-26T04:08:10.744Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq"}, {"id": "cm3xxscfv02nd7jww5qh826x7", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T04:08:10.744Z", "updatedAt": "2024-11-26T04:08:10.744Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq"}, {"id": "cm3xxscfv02nf7jww15uwyeav", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T04:08:10.744Z", "updatedAt": "2024-11-26T04:08:10.744Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq"}], "timesheets": [{"id": "cm3xpfpqc00cn7jwwlajsp8yc", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqe00cp7jww66rzeqw5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqf00cr7jww6murwxba", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqh00ct7jwwjrena8n2", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqi00cv7jwwthur880t", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpql00cx7jwwrsiljob9", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqm00cz7jwwdilqrcix", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqo00d17jwwnd4aqize", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqp00d37jww1pknk7qb", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqr00d57jwwdfmgenuc", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.744Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscft02n77jwwwhk8d5qq", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxscg602ni7jwwrhc4wrko", "userId": "emman", "createdAt": "2024-11-26T04:08:10.758Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9130, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.758Z", "daysWorked": 10, "deductions": [{"id": "cm3xxscgm02nk7jwwmicaxttd", "amount": 495, "userId": "emman", "createdAt": "2024-11-26T04:08:10.758Z", "updatedAt": "2024-11-26T04:08:10.758Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko"}, {"id": "cm3xxscgm02nm7jwwp56k7cqt", "amount": 275, "userId": "emman", "createdAt": "2024-11-26T04:08:10.758Z", "updatedAt": "2024-11-26T04:08:10.758Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko"}, {"id": "cm3xxscgm02no7jww9nlca7qf", "amount": 100, "userId": "emman", "createdAt": "2024-11-26T04:08:10.758Z", "updatedAt": "2024-11-26T04:08:10.758Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko"}, {"id": "cm3xxscgm02nq7jwwdk9hjr6l", "amount": 0, "userId": "emman", "createdAt": "2024-11-26T04:08:10.758Z", "updatedAt": "2024-11-26T04:08:10.758Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko"}], "timesheets": [{"id": "cm3xpfpsk00f77jwww0udziym", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "emman", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsl00f97jwwd3zfiez9", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "emman", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps700er7jwwguzzw1gu", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "emman", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps800et7jwws2xostwx", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "emman", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsa00ev7jwweulz8osz", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "emman", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsc00ex7jwwjagdg1xu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "emman", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsd00ez7jwwex8fhom3", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "emman", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsf00f17jwwk4nr18h2", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "emman", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsh00f37jwwbgpvfjfb", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "emman", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsi00f57jwwfc02oppe", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "emman", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.758Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscg602ni7jwwrhc4wrko", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1870, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxsch202nt7jww96fivvlo", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T04:08:10.789Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 9120, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.789Z", "daysWorked": 10, "deductions": [{"id": "cm3xxsch302nv7jwwcrp201l2", "amount": 495, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T04:08:10.789Z", "updatedAt": "2024-11-26T04:08:10.789Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxsch202nt7jww96fivvlo"}, {"id": "cm3xxsch302nx7jwwp6jv0amj", "amount": 275, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T04:08:10.789Z", "updatedAt": "2024-11-26T04:08:10.789Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxsch202nt7jww96fivvlo"}, {"id": "cm3xxsch302nz7jwwphu5s9av", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T04:08:10.789Z", "updatedAt": "2024-11-26T04:08:10.789Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxsch202nt7jww96fivvlo"}, {"id": "cm3xxsch302o17jwwwl8upp40", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T04:08:10.789Z", "updatedAt": "2024-11-26T04:08:10.789Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxsch202nt7jww96fivvlo"}, {"id": "cm3wx7w36000i7jwwcija1buc", "amount": 10, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T11:04:30.258Z", "updatedAt": "2024-11-26T04:08:10.789Z", "description": "test", "deductionType": "Disbursement", "payrollItemId": "cm3xxsch202nt7jww96fivvlo"}], "timesheets": [{"id": "cm3xpfpof00aj7jwwwa9r51ft", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoh00al7jwwgvzgnyvr", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoi00an7jwwuvnnydgu", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpok00ap7jwwczgbecof", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpom00ar7jww1uefyhm9", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpop00at7jww8brogkji", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpor00av7jww46tfhoag", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpou00ax7jwwpj4ncd8c", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpow00az7jwwvu3j6qq0", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpox00b17jww5mgwel14", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T04:08:10.789Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsch202nt7jww96fivvlo", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1880, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxschc02o47jwwkl7ce9yv", "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T04:08:10.799Z", "dailyRate": 2818.181818181818, "daysLeave": 0, "netSalary": 27474.9515, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.799Z", "daysWorked": 11, "deductions": [{"id": "cm3xxschd02o67jwwgwgneazs", "amount": 1125, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T04:08:10.799Z", "updatedAt": "2024-11-26T04:08:10.799Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv"}, {"id": "cm3xxschd02o87jwwjykt5hhx", "amount": 775, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T04:08:10.799Z", "updatedAt": "2024-11-26T04:08:10.799Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv"}, {"id": "cm3xxschd02oa7jwwkp613h2x", "amount": 100, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T04:08:10.799Z", "updatedAt": "2024-11-26T04:08:10.799Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv"}, {"id": "cm3xxschd02oc7jwwiv2as42n", "amount": 1525.0485, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T04:08:10.799Z", "updatedAt": "2024-11-26T04:08:10.799Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv"}], "timesheets": [{"id": "cm3xw9z6k01ri7jwwwahoh015", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z5w01qy7jww6ffnyqoh", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z5y01r07jwwxe5066z9", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6101r27jwwz67a5b18", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6301r47jwwo08vowis", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6501r67jwwty9oeu8r", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6801r87jww1ehxynkw", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6b01ra7jwwxhi72upc", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6d01rc7jwwi6h0gwvk", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6f01re7jwwonvhlgd9", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6h01rg7jwwjjjidvia", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.799Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschc02o47jwwkl7ce9yv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 31000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 3525.0485, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxschm02of7jwwt3niekn4", "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T04:08:10.810Z", "dailyRate": 5000, "daysLeave": 0, "netSalary": 46191.402, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.810Z", "daysWorked": 11, "deductions": [{"id": "cm3xxschn02oh7jwwneqq91h3", "amount": 1125, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T04:08:10.810Z", "updatedAt": "2024-11-26T04:08:10.810Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxschm02of7jwwt3niekn4"}, {"id": "cm3xxschn02oj7jwwey3t7pkz", "amount": 1375, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T04:08:10.810Z", "updatedAt": "2024-11-26T04:08:10.810Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxschm02of7jwwt3niekn4"}, {"id": "cm3xxscho02ol7jwwgghcysrc", "amount": 100, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T04:08:10.810Z", "updatedAt": "2024-11-26T04:08:10.810Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxschm02of7jwwt3niekn4"}, {"id": "cm3xxscho02on7jww7h63mfc5", "amount": 6208.598, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T04:08:10.810Z", "updatedAt": "2024-11-26T04:08:10.810Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxschm02of7jwwt3niekn4"}], "timesheets": [{"id": "cm3xw9yyc01ke7jwwefa50gpq", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxr01ju7jwwcrxqgc2w", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxu01jw7jwwq4qcu77m", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxv01jy7jwwltslhul4", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxx01k07jwwroje9ma8", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxz01k27jwwse58hvpj", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy201k47jww3ahywrw3", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy301k67jwwy0ss0af4", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy501k87jwwc7h0he1e", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy701ka7jwwx9y3cs4s", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy901kc7jwwz5yyqluz", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.810Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschm02of7jwwt3niekn4", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 55000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 8808.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxschx02oq7jwww3k1rjkt", "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T04:08:10.821Z", "dailyRate": 1000, "daysLeave": 0, "netSalary": 10130, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.821Z", "daysWorked": 11, "deductions": [{"id": "cm3xxschy02os7jwwrir3hrxf", "amount": 495, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T04:08:10.821Z", "updatedAt": "2024-11-26T04:08:10.821Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt"}, {"id": "cm3xxschz02ou7jwwqxulbexb", "amount": 275, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T04:08:10.821Z", "updatedAt": "2024-11-26T04:08:10.821Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt"}, {"id": "cm3xxschz02ow7jwwgevz0vgf", "amount": 100, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T04:08:10.821Z", "updatedAt": "2024-11-26T04:08:10.821Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt"}, {"id": "cm3xxschz02oy7jwwx1a9jud6", "amount": 0, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T04:08:10.821Z", "updatedAt": "2024-11-26T04:08:10.821Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt"}], "timesheets": [{"id": "cm3xw9y6q00uy7jwwihcyn0fo", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y6r00v07jwwclofzx30", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7400v27jww55g5gs19", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7600v47jwwgznnjozt", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7b00v67jwwa6d9cbxn", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7e00v87jwwk1o5kzmn", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7f00va7jww9rkkn3g2", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7h00vc7jwwy25d8zdt", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7j00ve7jww7ck03jw2", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7l00vg7jwwgjxhu239", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7p00vi7jwwnrklmqgt", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.821Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxschx02oq7jwww3k1rjkt", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 11000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 870, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxsci702p17jwwtzlyda8s", "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T04:08:10.831Z", "dailyRate": 3181.818181818182, "daysLeave": 0, "netSalary": 30691.402, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.831Z", "daysWorked": 11, "deductions": [{"id": "cm3xxsci802p37jww1ze0wv5e", "amount": 1125, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T04:08:10.831Z", "updatedAt": "2024-11-26T04:08:10.831Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxsci702p17jwwtzlyda8s"}, {"id": "cm3xxsci802p57jwwhy1cs05e", "amount": 875, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T04:08:10.831Z", "updatedAt": "2024-11-26T04:08:10.831Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxsci702p17jwwtzlyda8s"}, {"id": "cm3xxsci802p77jwwc1rnnthb", "amount": 100, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T04:08:10.831Z", "updatedAt": "2024-11-26T04:08:10.831Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxsci702p17jwwtzlyda8s"}, {"id": "cm3xxsci802p97jww6qu4mza1", "amount": 2208.598, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T04:08:10.831Z", "updatedAt": "2024-11-26T04:08:10.831Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxsci702p17jwwtzlyda8s"}], "timesheets": [{"id": "cm3xw9z2d01ns7jwwx336ykj5", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2f01nu7jwwlacofqa6", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2h01nw7jwwe28qnopg", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2l01ny7jww7wi9tfp3", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1o01ne7jwwk7mv990l", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1q01ng7jww5pwzy8q5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1s01ni7jwwcs3ax3lg", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1u01nk7jww04ilngwu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1w01nm7jwwajhginzi", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2a01no7jww7od8ww0u", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2c01nq7jww07mxz7ee", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.831Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsci702p17jwwtzlyda8s", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 35000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4308.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxscie02pc7jwwmtb4c9hv", "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T04:08:10.838Z", "dailyRate": 7818.181818181818, "daysLeave": 0, "netSalary": 69249.7025, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.838Z", "daysWorked": 11, "deductions": [{"id": "cm3xxscih02pe7jww80ngtvjo", "amount": 1125, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T04:08:10.838Z", "updatedAt": "2024-11-26T04:08:10.838Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv"}, {"id": "cm3xxscih02pg7jwwe72ys0rf", "amount": 2150, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T04:08:10.838Z", "updatedAt": "2024-11-26T04:08:10.838Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv"}, {"id": "cm3xxscih02pi7jwwqh544w3y", "amount": 100, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T04:08:10.838Z", "updatedAt": "2024-11-26T04:08:10.838Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv"}, {"id": "cm3xxscih02pk7jwwmj65wvst", "amount": 13375.2975, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T04:08:10.838Z", "updatedAt": "2024-11-26T04:08:10.838Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv"}], "timesheets": [{"id": "cm3xw9zes01ym7jww592he5vk", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze501y27jwwaqqdd6so", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze701y47jww8h30v2ln", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze901y67jwwi7rozry6", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zeb01y87jwwyec1f094", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zed01ya7jwwr38tyyxk", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zef01yc7jwwtymzvwmf", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zeh01ye7jwwa8zy77wk", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zek01yg7jwwa263pfha", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zel01yi7jww7qhifsy7", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zen01yk7jwwkz5lt3zw", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.838Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscie02pc7jwwmtb4c9hv", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 86000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 16750.2975, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxscip02pn7jww5pvm2uf5", "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T04:08:10.849Z", "dailyRate": 3636.363636363636, "daysLeave": 0, "netSalary": 34566.402, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.849Z", "daysWorked": 11, "deductions": [{"id": "cm3xxsciq02pp7jww11z2h86f", "amount": 1125, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T04:08:10.849Z", "updatedAt": "2024-11-26T04:08:10.849Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5"}, {"id": "cm3xxsciq02pr7jww7zgbc1hb", "amount": 1000, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T04:08:10.849Z", "updatedAt": "2024-11-26T04:08:10.849Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5"}, {"id": "cm3xxsciq02pt7jww2q0xfw4m", "amount": 100, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T04:08:10.849Z", "updatedAt": "2024-11-26T04:08:10.849Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5"}, {"id": "cm3xxsciq02pv7jwwdbx2j09w", "amount": 3208.598, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T04:08:10.849Z", "updatedAt": "2024-11-26T04:08:10.849Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5"}], "timesheets": [{"id": "cm3xw9yui01gs7jwwtzn931zm", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yul01gu7jwwg4xz1xop", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ytz01ga7jwwlwq975ke", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu101gc7jwwwwdmplgy", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu301ge7jwwutk98pof", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu501gg7jww30ovttm8", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu701gi7jwwaq5qyyjb", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yub01gk7jww8zna2i3o", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yuc01gm7jwwe4awejl4", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yue01go7jww529guvnu", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yug01gq7jww51utdev3", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.849Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscip02pn7jww5pvm2uf5", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 40000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 5433.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxsciy02py7jwwoqd09gra", "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T04:08:10.858Z", "dailyRate": 2272.727272727273, "daysLeave": 0, "netSalary": 22524.9515, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.858Z", "daysWorked": 11, "deductions": [{"id": "cm3xxscj002q07jwwijyltlz8", "amount": 1125, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T04:08:10.858Z", "updatedAt": "2024-11-26T04:08:10.858Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxsciy02py7jwwoqd09gra"}, {"id": "cm3xxscj002q27jwwt5d0c3bz", "amount": 625, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T04:08:10.858Z", "updatedAt": "2024-11-26T04:08:10.858Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxsciy02py7jwwoqd09gra"}, {"id": "cm3xxscj002q47jwwx0ngc9aq", "amount": 100, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T04:08:10.858Z", "updatedAt": "2024-11-26T04:08:10.858Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxsciy02py7jwwoqd09gra"}, {"id": "cm3xxscj002q67jwwhyovu10g", "amount": 625.0485000000002, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T04:08:10.858Z", "updatedAt": "2024-11-26T04:08:10.858Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxsciy02py7jwwoqd09gra"}], "timesheets": [{"id": "cm3xw9yqm01d67jwwpc0boe50", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqo01d87jwwfabx2vpr", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqs01da7jwws4z20b7g", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq601cq7jww9ebx5u3g", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq701cs7jwwrc2kk0ad", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq901cu7jwwzzthgfxq", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqb01cw7jww4y0nqf86", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqd01cy7jwwmo61cslx", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqg01d07jwwyhrnx2kh", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqi01d27jww1rc61peo", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqk01d47jwwj41qd1yj", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.858Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxsciy02py7jwwoqd09gra", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 25000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 2475.0485, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3xxscj802q97jww6ocjtbos", "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T04:08:10.868Z", "dailyRate": 3181.818181818182, "daysLeave": 0, "netSalary": 30691.402, "payrollId": "cm3xxscdy02mt7jwwqgvzhyj3", "updatedAt": "2024-11-26T04:08:10.868Z", "daysWorked": 11, "deductions": [{"id": "cm3xxscja02qb7jwwe3r2p1mz", "amount": 1125, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T04:08:10.868Z", "updatedAt": "2024-11-26T04:08:10.868Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3xxscj802q97jww6ocjtbos"}, {"id": "cm3xxscja02qd7jww4dy53csl", "amount": 875, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T04:08:10.868Z", "updatedAt": "2024-11-26T04:08:10.868Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3xxscj802q97jww6ocjtbos"}, {"id": "cm3xxscja02qf7jwwiiasl7hw", "amount": 100, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T04:08:10.868Z", "updatedAt": "2024-11-26T04:08:10.868Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3xxscj802q97jww6ocjtbos"}, {"id": "cm3xxscja02qh7jwwayr5cxa3", "amount": 2208.598, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T04:08:10.868Z", "updatedAt": "2024-11-26T04:08:10.868Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3xxscj802q97jww6ocjtbos"}], "timesheets": [{"id": "cm3xw9yit01647jwwn1kwl8cg", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yiv01667jwwdo0rhdxh", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yib015m7jww2ee9hlij", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yid015o7jwwn898thby", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yif015q7jwwg05wlds3", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yih015s7jwwa1k7jw5z", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yii015u7jwwf58d7lou", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yil015w7jwwl70hkega", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yin015y7jwwnu2oq91u", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yip01607jwwfjt4vwds", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yir01627jwwkdtv43f2", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T04:08:10.868Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3xxscj802q97jww6ocjtbos", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 35000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4308.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 05:20:20.077
cm3y7y85c000v11m2uj1ecyqb	PAYROLL	cm3y0dbqv02ro7jwwr97i9mpe	{"id": "cm3y0dbqv02ro7jwwr97i9mpe", "createdAt": "2024-11-26T05:20:28.855Z", "updatedAt": "2024-11-26T05:20:29.036Z", "totalAmount": 382944.3811363635, "payPeriodEnd": "2024-11-25T15:59:59.999Z", "payrollItems": [{"id": "cm3y0dbs302rr7jwwrivtxix2", "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T05:20:28.898Z", "dailyRate": 2818.181818181818, "daysLeave": 0, "netSalary": 27474.9515, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.898Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbs702rt7jwwngvsfc05", "amount": 1125, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T05:20:28.898Z", "updatedAt": "2024-11-26T05:20:28.898Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2"}, {"id": "cm3y0dbs702rv7jwwjoo7eti8", "amount": 775, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T05:20:28.898Z", "updatedAt": "2024-11-26T05:20:28.898Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2"}, {"id": "cm3y0dbs702rx7jww6cprkc1z", "amount": 100, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T05:20:28.898Z", "updatedAt": "2024-11-26T05:20:28.898Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2"}, {"id": "cm3y0dbs702rz7jwwxjgjo6yq", "amount": 1525.0485, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "createdAt": "2024-11-26T05:20:28.898Z", "updatedAt": "2024-11-26T05:20:28.898Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2"}], "timesheets": [{"id": "cm3xw9z6k01ri7jwwwahoh015", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z5w01qy7jww6ffnyqoh", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z5y01r07jwwxe5066z9", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6101r27jwwz67a5b18", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6301r47jwwo08vowis", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6501r67jwwty9oeu8r", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6801r87jww1ehxynkw", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6b01ra7jwwxhi72upc", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6d01rc7jwwi6h0gwvk", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6f01re7jwwonvhlgd9", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z6h01rg7jwwjjjidvia", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xv2tuq00ls7jwwsxzu6lcp", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.898Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbs302rr7jwwrivtxix2", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 31000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 3525.0485, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbsv02s27jwwez8hulfp", "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T05:20:28.927Z", "dailyRate": 3181.818181818182, "daysLeave": 0, "netSalary": 30691.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.927Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbsx02s47jwwherg8sgn", "amount": 1125, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T05:20:28.927Z", "updatedAt": "2024-11-26T05:20:28.927Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp"}, {"id": "cm3y0dbsx02s67jwwrq62gp69", "amount": 875, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T05:20:28.927Z", "updatedAt": "2024-11-26T05:20:28.927Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp"}, {"id": "cm3y0dbsx02s87jwwte7i7k27", "amount": 100, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T05:20:28.927Z", "updatedAt": "2024-11-26T05:20:28.927Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp"}, {"id": "cm3y0dbsx02sa7jwwin7s1jnf", "amount": 2208.598, "userId": "cm3xvd52v00n07jwwu9txe547", "createdAt": "2024-11-26T05:20:28.927Z", "updatedAt": "2024-11-26T05:20:28.927Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp"}], "timesheets": [{"id": "cm3xw9z2d01ns7jwwx336ykj5", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2f01nu7jwwlacofqa6", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2h01nw7jwwe28qnopg", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2l01ny7jww7wi9tfp3", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1o01ne7jwwk7mv990l", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1q01ng7jww5pwzy8q5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1s01ni7jwwcs3ax3lg", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1u01nk7jww04ilngwu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z1w01nm7jwwajhginzi", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2a01no7jww7od8ww0u", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9z2c01nq7jww07mxz7ee", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xvd52v00n07jwwu9txe547", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.927Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbsv02s27jwwez8hulfp", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 35000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4308.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbt902sd7jwwx8wrhbqx", "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T05:20:28.940Z", "dailyRate": 7818.181818181818, "daysLeave": 0, "netSalary": 69249.7025, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.940Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbta02sf7jww5hjwoc7e", "amount": 1125, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T05:20:28.940Z", "updatedAt": "2024-11-26T05:20:28.940Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx"}, {"id": "cm3y0dbta02sh7jww0u8hmlam", "amount": 2150, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T05:20:28.940Z", "updatedAt": "2024-11-26T05:20:28.940Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx"}, {"id": "cm3y0dbta02sj7jwwgrs333kk", "amount": 100, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T05:20:28.940Z", "updatedAt": "2024-11-26T05:20:28.940Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx"}, {"id": "cm3y0dbta02sl7jwwooyxvbzv", "amount": 13375.2975, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "createdAt": "2024-11-26T05:20:28.940Z", "updatedAt": "2024-11-26T05:20:28.940Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx"}], "timesheets": [{"id": "cm3xw9zes01ym7jww592he5vk", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze501y27jwwaqqdd6so", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze701y47jww8h30v2ln", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ze901y67jwwi7rozry6", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zeb01y87jwwyec1f094", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zed01ya7jwwr38tyyxk", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zef01yc7jwwtymzvwmf", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zeh01ye7jwwa8zy77wk", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zek01yg7jwwa263pfha", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zel01yi7jww7qhifsy7", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zen01yk7jwwkz5lt3zw", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xvamu600mp7jwwmgb1kf5e", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.940Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbt902sd7jwwx8wrhbqx", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 86000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 16750.2975, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbth02so7jwwtgzp3xs8", "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T05:20:28.949Z", "dailyRate": 3636.363636363636, "daysLeave": 0, "netSalary": 34566.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.949Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbtj02sq7jwwh163er0z", "amount": 1125, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T05:20:28.949Z", "updatedAt": "2024-11-26T05:20:28.949Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8"}, {"id": "cm3y0dbtj02ss7jwwx7zxskhs", "amount": 1000, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T05:20:28.949Z", "updatedAt": "2024-11-26T05:20:28.949Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8"}, {"id": "cm3y0dbtj02su7jwwq83hjd1i", "amount": 100, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T05:20:28.949Z", "updatedAt": "2024-11-26T05:20:28.949Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8"}, {"id": "cm3y0dbtj02sw7jwwq3lgmhyi", "amount": 3208.598, "userId": "cm3xuz9oj00lh7jww07cy3cil", "createdAt": "2024-11-26T05:20:28.949Z", "updatedAt": "2024-11-26T05:20:28.949Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8"}], "timesheets": [{"id": "cm3xw9yui01gs7jwwtzn931zm", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yul01gu7jwwg4xz1xop", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ytz01ga7jwwlwq975ke", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu101gc7jwwwwdmplgy", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu301ge7jwwutk98pof", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu501gg7jww30ovttm8", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yu701gi7jwwaq5qyyjb", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yub01gk7jww8zna2i3o", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yuc01gm7jwwe4awejl4", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yue01go7jww529guvnu", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yug01gq7jww51utdev3", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xuz9oj00lh7jww07cy3cil", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.949Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbth02so7jwwtgzp3xs8", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 40000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 5433.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbtq02sz7jww7kohxizk", "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T05:20:28.958Z", "dailyRate": 2272.727272727273, "daysLeave": 0, "netSalary": 22524.9515, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.958Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbts02t17jww7994mjap", "amount": 1125, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T05:20:28.958Z", "updatedAt": "2024-11-26T05:20:28.958Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk"}, {"id": "cm3y0dbts02t37jwwix3xvcvu", "amount": 625, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T05:20:28.958Z", "updatedAt": "2024-11-26T05:20:28.958Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk"}, {"id": "cm3y0dbts02t57jwwpxe8wt9s", "amount": 100, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T05:20:28.958Z", "updatedAt": "2024-11-26T05:20:28.958Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk"}, {"id": "cm3y0dbts02t77jwwsmver4ad", "amount": 625.0485000000002, "userId": "cm3xusu1p00l67jwwmm29up9j", "createdAt": "2024-11-26T05:20:28.958Z", "updatedAt": "2024-11-26T05:20:28.958Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk"}], "timesheets": [{"id": "cm3xw9yqm01d67jwwpc0boe50", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqo01d87jwwfabx2vpr", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqs01da7jwws4z20b7g", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq601cq7jww9ebx5u3g", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq701cs7jwwrc2kk0ad", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yq901cu7jwwzzthgfxq", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqb01cw7jww4y0nqf86", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqd01cy7jwwmo61cslx", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqg01d07jwwyhrnx2kh", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqi01d27jww1rc61peo", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yqk01d47jwwj41qd1yj", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xusu1p00l67jwwmm29up9j", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.958Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtq02sz7jww7kohxizk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 25000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 2475.0485, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbtz02ta7jwwg5743mb0", "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T05:20:28.966Z", "dailyRate": 3181.818181818182, "daysLeave": 0, "netSalary": 30691.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.966Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbu002tc7jwwrc7f094g", "amount": 1125, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T05:20:28.966Z", "updatedAt": "2024-11-26T05:20:28.966Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0"}, {"id": "cm3y0dbu002te7jwwsnam3vp3", "amount": 875, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T05:20:28.966Z", "updatedAt": "2024-11-26T05:20:28.966Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0"}, {"id": "cm3y0dbu002tg7jwwebtkhov7", "amount": 100, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T05:20:28.966Z", "updatedAt": "2024-11-26T05:20:28.966Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0"}, {"id": "cm3y0dbu002ti7jww5kv572hc", "amount": 2208.598, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "createdAt": "2024-11-26T05:20:28.966Z", "updatedAt": "2024-11-26T05:20:28.966Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0"}], "timesheets": [{"id": "cm3xw9yit01647jwwn1kwl8cg", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yiv01667jwwdo0rhdxh", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yib015m7jww2ee9hlij", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yid015o7jwwn898thby", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yif015q7jwwg05wlds3", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yih015s7jwwa1k7jw5z", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yii015u7jwwf58d7lou", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yil015w7jwwl70hkega", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yin015y7jwwnu2oq91u", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yip01607jwwfjt4vwds", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yir01627jwwkdtv43f2", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xuoj8d00kv7jwwop9hwrrk", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.966Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbtz02ta7jwwg5743mb0", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 35000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4308.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbua02tl7jww16192xls", "userId": "cm3xv6vyj00me7jww8fatnd46", "createdAt": "2024-11-26T05:20:28.978Z", "dailyRate": 3272.727272727273, "daysLeave": 0, "netSalary": 31466.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.978Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbub02tn7jwws7ysvuuy", "amount": 1125, "userId": "cm3xv6vyj00me7jww8fatnd46", "createdAt": "2024-11-26T05:20:28.978Z", "updatedAt": "2024-11-26T05:20:28.978Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbua02tl7jww16192xls"}, {"id": "cm3y0dbub02tp7jww7s6vnjx4", "amount": 900, "userId": "cm3xv6vyj00me7jww8fatnd46", "createdAt": "2024-11-26T05:20:28.978Z", "updatedAt": "2024-11-26T05:20:28.978Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbua02tl7jww16192xls"}, {"id": "cm3y0dbub02tr7jww20sn3h0o", "amount": 100, "userId": "cm3xv6vyj00me7jww8fatnd46", "createdAt": "2024-11-26T05:20:28.978Z", "updatedAt": "2024-11-26T05:20:28.978Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbua02tl7jww16192xls"}, {"id": "cm3y0dbub02tt7jwwpqdu4frc", "amount": 2408.598, "userId": "cm3xv6vyj00me7jww8fatnd46", "createdAt": "2024-11-26T05:20:28.978Z", "updatedAt": "2024-11-26T05:20:28.978Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbua02tl7jww16192xls"}], "timesheets": [{"id": "cm3xw9zam01v07jwwg7oeu39k", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zap01v27jww6e6w9e5e", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9za101ui7jwwwrerac6p", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9za301uk7jwwgr3ade73", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9za601um7jwwde9cn8mm", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9za801uo7jwwekf2oqkd", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zaa01uq7jww3kdn33kz", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zae01us7jww6owdjxmj", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zag01uu7jww3bs2p8zk", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zai01uw7jwwruyf4qlc", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9zak01uy7jwwbwkp1mib", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xv6vyj00me7jww8fatnd46", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.978Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbua02tl7jww16192xls", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 36000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4533.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbui02tw7jww03qny82v", "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T05:20:28.986Z", "dailyRate": 3272.727272727273, "daysLeave": 0, "netSalary": 31466.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.986Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbuj02ty7jww3mez3rtj", "amount": 1125, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T05:20:28.986Z", "updatedAt": "2024-11-26T05:20:28.986Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbui02tw7jww03qny82v"}, {"id": "cm3y0dbuj02u07jww7b8ky5bx", "amount": 900, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T05:20:28.986Z", "updatedAt": "2024-11-26T05:20:28.986Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbui02tw7jww03qny82v"}, {"id": "cm3y0dbuj02u27jww11ofxlkk", "amount": 100, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T05:20:28.986Z", "updatedAt": "2024-11-26T05:20:28.986Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbui02tw7jww03qny82v"}, {"id": "cm3y0dbuj02u47jwwtkcszwn0", "amount": 2408.598, "userId": "cm3xufw6p00k97jww8n9qq7fq", "createdAt": "2024-11-26T05:20:28.986Z", "updatedAt": "2024-11-26T05:20:28.986Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbui02tw7jww03qny82v"}], "timesheets": [{"id": "cm3xw9ylx01967jwwxdrolzoq", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ylz01987jwws9mrv0kf", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym0019a7jwwjeguwkaa", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym3019c7jwwil7961g1", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ym4019e7jwwxrxns977", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yml019g7jwwlv02pfab", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymm019i7jwwmybiurg3", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymo019k7jwwz5zaz234", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymq019m7jwwrtqw8m9c", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymt019o7jwwg4exwua0", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9ymw019q7jwwk5kaea6d", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xufw6p00k97jww8n9qq7fq", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:28.986Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbui02tw7jww03qny82v", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 36000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 4533.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbuq02u77jwwyz5dr7x3", "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T05:20:28.994Z", "dailyRate": 1454.545454545455, "daysLeave": 0, "netSalary": 13325.45454545455, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:28.994Z", "daysWorked": 10, "deductions": [{"id": "cm3y0dbus02u97jwwcpquk96c", "amount": 720, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T05:20:28.994Z", "updatedAt": "2024-11-26T05:20:28.994Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3"}, {"id": "cm3y0dbus02ub7jww62su8rmg", "amount": 400, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T05:20:28.994Z", "updatedAt": "2024-11-26T05:20:28.994Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3"}, {"id": "cm3y0dbus02ud7jwwhwe0tgvz", "amount": 100, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T05:20:28.994Z", "updatedAt": "2024-11-26T05:20:28.994Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3"}, {"id": "cm3y0dbus02uf7jww4r373dps", "amount": 0, "userId": "cm3sd5sob000698xytgsayvvu", "createdAt": "2024-11-26T05:20:28.994Z", "updatedAt": "2024-11-26T05:20:28.994Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3"}], "timesheets": [{"id": "cm3xpfpqc00cn7jwwlajsp8yc", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqe00cp7jww66rzeqw5", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqf00cr7jww6murwxba", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqh00ct7jwwjrena8n2", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqi00cv7jwwthur880t", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpql00cx7jwwrsiljob9", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqm00cz7jwwdilqrcix", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqo00d17jwwnd4aqize", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqp00d37jww1pknk7qb", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpqr00d57jwwdfmgenuc", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd5sob000698xytgsayvvu", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:28.994Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbuq02u77jwwyz5dr7x3", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 16000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 2674.545454545455, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbv002ui7jwwnk3svm55", "userId": "emman", "createdAt": "2024-11-26T05:20:29.004Z", "dailyRate": 1454.545454545455, "daysLeave": 0, "netSalary": 13325.45454545455, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:29.004Z", "daysWorked": 10, "deductions": [{"id": "cm3y0dbv202uk7jwwkp82fp62", "amount": 720, "userId": "emman", "createdAt": "2024-11-26T05:20:29.004Z", "updatedAt": "2024-11-26T05:20:29.004Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55"}, {"id": "cm3y0dbv202um7jwwehzinors", "amount": 400, "userId": "emman", "createdAt": "2024-11-26T05:20:29.004Z", "updatedAt": "2024-11-26T05:20:29.004Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55"}, {"id": "cm3y0dbv202uo7jwwhzjc6y0h", "amount": 100, "userId": "emman", "createdAt": "2024-11-26T05:20:29.004Z", "updatedAt": "2024-11-26T05:20:29.004Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55"}, {"id": "cm3y0dbv202uq7jwwwd1rgu4q", "amount": 0, "userId": "emman", "createdAt": "2024-11-26T05:20:29.004Z", "updatedAt": "2024-11-26T05:20:29.004Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55"}], "timesheets": [{"id": "cm3xpfpsk00f77jwww0udziym", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "emman", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsl00f97jwwd3zfiez9", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "emman", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps700er7jwwguzzw1gu", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "emman", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfps800et7jwws2xostwx", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "emman", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsa00ev7jwweulz8osz", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "emman", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsc00ex7jwwjagdg1xu", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "emman", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsd00ez7jwwex8fhom3", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "emman", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsf00f17jwwk4nr18h2", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "emman", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsh00f37jwwbgpvfjfb", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "emman", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpsi00f57jwwfc02oppe", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "emman", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.004Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv002ui7jwwnk3svm55", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 16000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 2674.545454545455, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbv902ut7jwwhl11wagk", "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T05:20:29.013Z", "dailyRate": 1454.545454545455, "daysLeave": 0, "netSalary": 13315.45454545455, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:29.013Z", "daysWorked": 10, "deductions": [{"id": "cm3y0dbva02uv7jwwnf87mfy2", "amount": 720, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T05:20:29.013Z", "updatedAt": "2024-11-26T05:20:29.013Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk"}, {"id": "cm3y0dbva02ux7jwwqogxholk", "amount": 400, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T05:20:29.013Z", "updatedAt": "2024-11-26T05:20:29.013Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk"}, {"id": "cm3y0dbva02uz7jwwacy9zntb", "amount": 100, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T05:20:29.013Z", "updatedAt": "2024-11-26T05:20:29.013Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk"}, {"id": "cm3y0dbvb02v17jww5v5lzywj", "amount": 0, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-26T05:20:29.013Z", "updatedAt": "2024-11-26T05:20:29.013Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk"}, {"id": "cm3wx7w36000i7jwwcija1buc", "amount": 10, "userId": "cm3sd6n7y000h98xyfpmb6any", "createdAt": "2024-11-25T11:04:30.258Z", "updatedAt": "2024-11-26T05:20:29.013Z", "description": "test", "deductionType": "Disbursement", "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk"}], "timesheets": [{"id": "cm3xpfpof00aj7jwwwa9r51ft", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoh00al7jwwgvzgnyvr", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpoi00an7jwwuvnnydgu", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpok00ap7jwwczgbecof", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpom00ar7jww1uefyhm9", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpop00at7jww8brogkji", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpor00av7jww46tfhoag", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpou00ax7jwwpj4ncd8c", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpow00az7jwwvu3j6qq0", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xpfpox00b17jww5mgwel14", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3sd6n7y000h98xyfpmb6any", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T00:14:24.378Z", "updatedAt": "2024-11-26T05:20:29.013Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbv902ut7jwwhl11wagk", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 16000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6000, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 2684.545454545455, "minutesNotWorked": 600, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbvh02v47jwwt3ho3akr", "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T05:20:29.021Z", "dailyRate": 5454.545454545455, "daysLeave": 0, "netSalary": 50066.402, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:29.021Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbvi02v67jwwtp3seg4f", "amount": 1125, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T05:20:29.021Z", "updatedAt": "2024-11-26T05:20:29.021Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr"}, {"id": "cm3y0dbvi02v87jwwi8v7u9dl", "amount": 1500, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T05:20:29.021Z", "updatedAt": "2024-11-26T05:20:29.021Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr"}, {"id": "cm3y0dbvi02va7jww02rqqjlx", "amount": 100, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T05:20:29.021Z", "updatedAt": "2024-11-26T05:20:29.021Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr"}, {"id": "cm3y0dbvi02vc7jwwdmfmu9d5", "amount": 7208.598, "userId": "cm3xv4w6000m37jww5tkffps0", "createdAt": "2024-11-26T05:20:29.021Z", "updatedAt": "2024-11-26T05:20:29.021Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr"}], "timesheets": [{"id": "cm3xw9yyc01ke7jwwefa50gpq", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxr01ju7jwwcrxqgc2w", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxu01jw7jwwq4qcu77m", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxv01jy7jwwltslhul4", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxx01k07jwwroje9ma8", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yxz01k27jwwse58hvpj", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy201k47jww3ahywrw3", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy301k67jwwy0ss0af4", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy501k87jwwc7h0he1e", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy701ka7jwwx9y3cs4s", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9yy901kc7jwwz5yyqluz", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xv4w6000m37jww5tkffps0", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.021Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvh02v47jwwt3ho3akr", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 60000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 9933.598, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}, {"id": "cm3y0dbvp02vf7jwwsulotr54", "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T05:20:29.029Z", "dailyRate": 1454.545454545455, "daysLeave": 0, "netSalary": 14780, "payrollId": "cm3y0dbqv02ro7jwwr97i9mpe", "updatedAt": "2024-11-26T05:20:29.029Z", "daysWorked": 11, "deductions": [{"id": "cm3y0dbvq02vh7jwwf9th359c", "amount": 720, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T05:20:29.029Z", "updatedAt": "2024-11-26T05:20:29.029Z", "description": "SSS contribution", "deductionType": "SSS", "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54"}, {"id": "cm3y0dbvq02vj7jwwbpq63jit", "amount": 400, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T05:20:29.029Z", "updatedAt": "2024-11-26T05:20:29.029Z", "description": "PhilHealth contribution", "deductionType": "PhilHealth", "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54"}, {"id": "cm3y0dbvq02vl7jwwkg8tebea", "amount": 100, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T05:20:29.029Z", "updatedAt": "2024-11-26T05:20:29.029Z", "description": "PagIBIG contribution", "deductionType": "PagIBIG", "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54"}, {"id": "cm3y0dbvr02vn7jwwu1a5a4j9", "amount": 0, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "createdAt": "2024-11-26T05:20:29.029Z", "updatedAt": "2024-11-26T05:20:29.029Z", "description": "Tax contribution", "deductionType": "Tax", "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54"}], "timesheets": [{"id": "cm3xw9y6r00v07jwwclofzx30", "dayId": "clropux1500ld98xyulc1qclh", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-12T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-12T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7400v27jww55g5gs19", "dayId": "clropux1700lg98xyu0srgkzu", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-13T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-13T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7600v47jwwgznnjozt", "dayId": "clropux1900lj98xyeuld28xu", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-14T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-14T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7b00v67jwwa6d9cbxn", "dayId": "clropux1b00lm98xy8ylikutk", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-15T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-15T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7e00v87jwwk1o5kzmn", "dayId": "clropux1h00lr98xypqf58wrh", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-18T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-18T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7f00va7jww9rkkn3g2", "dayId": "clropux1k00lu98xy3e1azdw9", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-19T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-19T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7h00vc7jwwy25d8zdt", "dayId": "clropux1n00lx98xy1i7exfqy", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-20T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-20T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7j00ve7jww7ck03jw2", "dayId": "clropux1p00m098xyaz6rw480", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-21T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-21T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7l00vg7jwwgjxhu239", "dayId": "clropux1r00m398xy6fxll2mn", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-22T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-22T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y7p00vi7jwwnrklmqgt", "dayId": "clropux1x00m898xyeb65o59h", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-25T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-25T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}, {"id": "cm3xw9y6q00uy7jwwihcyn0fo", "dayId": "clropux1300la98xyltx84oyo", "isLate": false, "userId": "cm3xu8bx700jn7jwwlfh8k68g", "clockIn": "2024-11-11T00:00:00.000Z", "isLeave": false, "clockOut": "2024-11-11T10:00:00.000Z", "createdAt": "2024-11-26T03:25:52.719Z", "updatedAt": "2024-11-26T05:20:29.029Z", "isAdvanced": true, "isOvertime": false, "minutesLate": 0, "clockOutEarly": false, "payrollItemId": "cm3y0dbvp02vf7jwwsulotr54", "forgotClockOut": false, "minutesOvertime": 0, "clockOutEarlyMinutes": 0}], "basicSalary": 16000, "minutesLate": 0, "daysNotWorked": [], "minutesWorked": 6600, "lateDeductions": 0, "overtimeSalary": 0, "minutesEarlyOut": 0, "minutesOvertime": 0, "totalDeductions": 1220, "minutesNotWorked": 0, "specialDayMinutes": 0, "additionalEarnings": [], "daysNotWorkedArray": [], "specialDayEarnings": 0, "additionalEarningsArray": [], "earlyClockOutDeductions": 0}], "payrollStatus": "PENDING", "payPeriodStart": "2024-11-10T16:00:00.000Z"}	2024-11-26 08:52:41.28
\.


--
-- Data for Name: AssignDesignation; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AssignDesignation" ("id", "employeeType", "status", "designationId", "userId", "createdAt", "updatedAt") FROM stdin;
cm3sd6n80000j98xyig5zzqpg	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3sd6n7y000h98xyfpmb6any	2024-11-22 06:32:35.086	2024-11-25 04:00:50.976
cm3wbvc4w000lryyfb47hu887	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	emman	2024-11-25 01:06:52.592	2024-11-25 04:01:20.506
cm3xpo5f000fr7jwwvcm17s1e	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3sd5sob000698xytgsayvvu	2024-11-26 00:20:58.092	2024-11-26 00:20:58.092
cm3xufw6r00kb7jwwnz9yhm89	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3xufw6p00k97jww8n9qq7fq	2024-11-26 02:34:30.961	2024-11-26 02:34:30.961
cm3xv2tut00lu7jwwrucxi3lh	REGULAR	ACTIVE	cm3xvruoh00nz7jwwm2qx42s3	cm3xv2tuq00ls7jwwsxzu6lcp	2024-11-26 02:52:21.026	2024-11-26 03:11:48.501
cm3xu8bxb00jp7jwwpqyrn7ph	REGULAR	ACTIVE	cm3xvscbm00o37jwwshowk8sh	cm3xu8bx700jn7jwwlfh8k68g	2024-11-26 02:28:38.105	2024-11-26 03:12:11.364
cm3xvamu800mr7jww75b37ght	REGULAR	ACTIVE	cm3xvta2r00ob7jww97mmy8gv	cm3xvamu600mp7jwwmgb1kf5e	2024-11-26 02:58:25.182	2024-11-26 03:12:55.112
cm3xvuoxp00pn7jww33f9cr5m	REGULAR	ACTIVE	cm3xvscbm00o37jwwshowk8sh	cm3xv4w6000m37jww5tkffps0	2024-11-26 03:14:01.022	2024-11-26 03:14:01.022
cm3xvv94700pz7jwwqlwbfqh3	REGULAR	ACTIVE	cm3xvta2r00ob7jww97mmy8gv	cm3xvd52v00n07jwwu9txe547	2024-11-26 03:14:27.175	2024-11-26 03:14:27.175
cm3xvulr600ph7jwwwhkv8d6y	REGULAR	ACTIVE	cm3xvxjtp00ql7jwwn23lxirz	cm3xusu1p00l67jwwmm29up9j	2024-11-26 03:13:56.898	2024-11-26 03:16:14.367
cm3xvxz7500qr7jww7g16s07h	REGULAR	ACTIVE	cm3xvxjtp00ql7jwwn23lxirz	cm3xuz9oj00lh7jww07cy3cil	2024-11-26 03:16:34.29	2024-11-26 03:16:34.29
cm3xvv19x00pt7jww4ub7vcwh	REGULAR	ACTIVE	cm3xw1yqq00rv7jwwild4i9pw	cm3xuoj8d00kv7jwwop9hwrrk	2024-11-26 03:14:17.014	2024-11-26 03:19:40.324
cm3xxynri02r57jwwvmpohouh	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3xv6vyj00me7jww8fatnd46	2024-11-26 04:13:05.358	2024-11-26 04:13:05.358
cm3y0p32b02w37jwwcxbym77a	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3xud7bl00jy7jww9qzfi51c	2024-11-26 05:29:37.476	2024-11-26 05:29:37.476
cm3y7pz24000f11m29ylp7j5x	REGULAR	ACTIVE	cm3xvruoh00nz7jwwm2qx42s3	cm3y7pz20000d11m2522rpsoa	2024-11-26 08:46:16.247	2024-11-26 08:46:16.247
cm3y84f6h006011m2ddzjomud	REGULAR	ACTIVE	cm3rif3dd0007uks9t239m816	cm3xuj38h00kk7jwwnwywtik2	2024-11-26 08:57:30.33	2024-11-26 08:57:30.33
\.


--
-- Data for Name: AuditLog; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."AuditLog" ("id", "userId", "action", "createdAt") FROM stdin;
cm3rienxx0001uks98mx37a1z	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-21 16:11:01.173
cm3rif3d80005uks92n6wod7u	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-21 16:11:21.164
cm3rif3e0000duks9voi6z8n4	emman	User "Emmanuel Aguado" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-21 16:11:21.192
cm3scftyn000198xyyg688pv5	emman	User Log-Out	2024-11-22 06:11:44.111
cm3sd4n2s000498xygtcq25fw	emman	User Log-In	2024-11-22 06:31:01.588
cm3sd5sou000f98xyf46u6xdw	emman	User "Ellyanna Nicole Du" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 06:31:55.519
cm3sd6n89000q98xymuuwd8ga	emman	User "Shan Tranquilan" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 06:32:35.097
cm3sd6pi9000s98xyqtvxeqza	emman	User Log-Out	2024-11-22 06:32:38.05
cm3sffaiw000v98xyp07u7upa	emman	User Log-In	2024-11-22 07:35:17.768
cm3sffeuv000x98xytrdiil0s	emman	User Log-Out	2024-11-22 07:35:23.384
cm3sfg39b001098xyivkgnsut	emman	User Password Reset	2024-11-22 07:35:55.007
cm3sfvas1001298xy03k8nk94	emman	User Log-In	2024-11-22 07:47:44.593
cm3sgdkwb001498xybe8nf0bn	emman	User Address Add	2024-11-22 08:01:57.515
cm3sgw67w001898xy631mkh7l	emman	User Emergency Contact Add	2024-11-22 08:16:24.955
cm3shuu0o001c98xy7axvn7ao	emman	User Password Reset	2024-11-22 08:43:22.103
clropux5600p398xyfqmqdnsv	emman	Working Days, Months, and Constant Holidays For The Year Generated by Superadmin: Emmanuel Diaz Aguado	2024-01-22 09:19:50.347
cm3sj5lvd00p598xya031rw3y	emman	User Log-In	2024-11-22 09:19:44.377
cm3sk6xs500p798xyv4onwksi	emman	Holiday Created by Superadmin: Emmanuel Diaz Aguado	2024-11-22 09:48:46.085
cm3skauf000pa98xytfxmjcap	emman	Holiday Created by Superadmin: Emmanuel Diaz Aguado	2024-11-22 09:51:48.348
cm3sklawq00pf98xyvqfsmc75	emman	Special working day created for 12/1/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 09:59:56.282
cm3skmfam00ph98xy9moxl1ci	emman	Special working day created for 12/1/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 10:00:48.622
cm3slj4u500s198xyn0ydoj7e	emman	Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 10:26:14.717
cm3sr8d5g00s798xyr43vq90y	emman	Holiday Created by Superadmin: Emmanuel Diaz Aguado	2024-11-22 13:05:49.971
cm3sr8h9p00sb98xyexuu0ok9	emman	Holiday Removed by Superadmin: Emmanuel Diaz Aguado	2024-11-22 13:05:55.309
cm3srcbjk00t998xylwmbl6y5	emman	Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 13:08:54.512
cm3srzf3y00tc98xycsjblhcp	emman	Undid Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-22 13:26:52.202
cm3sskldd00tg98xyk2wflhoq	emman	User Timesheet Clock In	2024-11-22 13:43:20.113
cm3ssx77v00tk98xyyukobnn0	emman	User Timesheet Clock In	2024-11-22 13:53:08.3
cm3ssys5n00tm98xyf14geh9o	emman	User Timesheet Clock Out	2024-11-22 13:54:22.091
cm3srm8w500tq98xyskjxtqr5	emman	User started Overtime	2024-11-22 13:16:37.637
cm3srpr9q00ts98xyhdu5pa8n	emman	User ended Overtime	2024-11-22 13:19:21.422
cm3srszj900tu98xylgmzrq9h	emman	User Timesheet Clock Out	2024-11-22 13:21:52.101
cm3sva95v00ty98xyucyy5oau	emman	User requested SICK leave from 2024-12-02 to 2024-12-12	2024-11-22 14:59:16.58
cm3tnk1xr0001ryyfuiaryo2o	emman	Leave REJECTED by SUPERADMIN: Emmanuel Diaz Aguado	2024-11-23 04:10:43.022
cm3w8dcjs0003ryyfjzzcnhw2	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-24 23:28:54.472
cm3w8m2ln0007ryyfbveqtfmo	emman	Department Updated by SuperAdmin: Emmanuel Diaz Aguado	2024-11-24 23:35:41.483
cm3wbut6k000bryyfelhvx8vc	emman	User "Emmanuel Aguado" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-25 01:06:28.029
cm3wbv57c000fryyfp3ts41ka	emman	User "Ellyanna Nicole Du" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-25 01:06:43.608
cm3wbvc4v000jryyfv8vqc53b	emman	User "Emmanuel Aguado" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-25 01:06:52.591
cm3wevxzv000nryyfi1613nvd	emman	Changed role of user "Shan Tranquilan" to SUPERADMIN by SuperAdmin: Emmanuel Diaz Aguado	2024-11-25 02:31:19.772
cm3wi32fp000pryyfeykqfypt	emman	User "Shan Tranquilan" assignment details updated by Admin: Emmanuel Diaz Aguado	2024-11-25 04:00:50.965
cm3wi3p7w000rryyf9kedcguw	emman	User "Emmanuel Aguado" assignment details updated by Admin: Emmanuel Diaz Aguado	2024-11-25 04:01:20.492
cm3wmqoaw000zryyf0aior144	emman	Edited salary for designation Hacking Designation from $5000 to $6000 by Super Admin: Emmanuel Diaz Aguado	2024-11-25 06:11:10.856
cm3wqlsnu0012ryyfuh0s7wuq	emman	Payroll generated for period 11/1/2024 to 11/30/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-25 07:59:21.69
cm3wruj6h001zryyf6h0rcyuj	emman	Employees added to Payroll by SuperAdmin: Emmanuel Diaz Aguado	2024-11-25 08:34:08.922
cm3wvezgr00017jwwb0rt06te	cm3sd6n7y000h98xyfpmb6any	User Log-In	2024-11-25 10:14:01.995
cm3wvh78600037jww6txu4uln	cm3sd6n7y000h98xyfpmb6any	Holiday Created by Superadmin: Shan Nuel Tranquilan	2024-11-25 10:15:45.367
cm3wvjlm600067jwwk5grz9im	cm3sd5sob000698xytgsayvvu	User Log-In	2024-11-25 10:17:37.327
cm3ww1e0n00087jww583pepjc	emman	Allowance Created by Super Admin: Emmanuel Diaz Aguado	2024-11-25 10:31:27.287
cm3ww1mub000c7jww609o7oh0	emman	Toggled Allowance Status by: Emmanuel Diaz Aguado	2024-11-25 10:31:38.723
cm3ww27bu000e7jwwrhxaw6ll	emman	Toggled Allowance Status by: Emmanuel Diaz Aguado	2024-11-25 10:32:05.274
cm3wx7w2w000g7jwwfjkuidyd	emman	Multiple Deductions Added by Admin: Emmanuel Diaz Aguado	2024-11-25 11:04:30.248
cm3xpca62008v7jww7f9hbec5	emman	Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:11:44.379
cm3xpfpsn00fb7jwwn4lvclyj	emman	Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:14:24.6
cm3xpiks400fe7jwwek3fmzeu	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:16:38.069
cm3xpm5tf00fi7jwwo49gof02	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 00:19:25.3
cm3xpm72500fl7jwwidzsgc1x	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:19:26.909
cm3xpo5ey00fp7jwwsq4qahlz	emman	User "Ellyanna Nicole Du" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 00:20:58.09
cm3xpqpss00fv7jwwtp7x9s0w	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 00:22:57.821
cm3xpr8nk00fz7jwwoae829yh	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 00:23:22.257
cm3xpr9xn00g27jwwb1fa9bgq	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:23:23.916
cm3xpuk7s00h47jwwulliqihy	emman	Employees added to Payroll by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:25:57.209
cm3xpvr3g00h87jwwc7dk5avk	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 00:26:52.78
cm3xpz1ty00i87jww288hhvqc	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 00:29:26.662
cm3xpzsp300ib7jwwvxb952cx	emman	Removed employee cm3sd6n7y000h98xyfpmb6any from payroll cm3xpz1sj00h97jww7q2618b9 by: Emmanuel Diaz Aguado	2024-11-26 00:30:01.48
cm3xpzw1m00ie7jww5x28ighz	emman	Removed employee cm3sd5sob000698xytgsayvvu from payroll cm3xpz1sj00h97jww7q2618b9 by: Emmanuel Diaz Aguado	2024-11-26 00:30:05.818
cm3xpzywz00ih7jwwa7obaerd	emman	Removed employee emman from payroll cm3xpz1sj00h97jww7q2618b9 by: Emmanuel Diaz Aguado	2024-11-26 00:30:09.539
cm3xrb5ww00il7jwwfjp0ncku	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 01:06:51.44
cm3xrb72x00jl7jwwkn8741f5	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 01:06:52.954
cm3xu8eni00jw7jwwv7qsi3up	emman	User "Julian  Vasquez" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:28:41.647
cm3xud8ah00k77jww6gvd1dmu	emman	User "Francis Paolo  Echavez" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:32:26.681
cm3xufxed00ki7jww85umbdjg	emman	User "Bryan Neil Floresta" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:34:32.534
cm3xuj44i00kt7jwwy2zepjyq	emman	User "Jousheen Ly Salac" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:37:01.218
cm3xuokbi00l47jwwprvjpduf	emman	User "Bon Reparial" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:41:15.486
cm3xusux000lf7jwwzfx4jycx	emman	User "Kyle Caballes" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:44:35.845
cm3xuzaxz00lq7jwwdtw0vv5d	emman	User "Dutch der Linde" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:49:36.551
cm3xv2ukn00m17jwwg6vyld50	emman	User "Kentavious Pope" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:52:21.959
cm3xv4wy100mc7jww2ovwpggw	emman	User "Marlo Magdangal" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:53:58.345
cm3xv6wsk00mn7jwwllol4v1g	emman	User "Reanne Kevin Angcos" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:55:31.46
cm3xvao0700my7jwwdey8yd4n	emman	User "Ivan Lo" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 02:58:26.695
cm3xvd69100n97jwwmweyru7w	emman	User "Richard Jame Deano" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:00:23.654
cm3xvfu4c00nk7jwwyu7xwl3f	emman	User "Miguel Co" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:02:27.901
cm3xvib1q00nv7jww8q8gd3jn	emman	User "Kyle Tabla" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:04:23.151
cm3xvruo200nx7jww0d5fe2av	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:11:48.482
cm3xvscbi00o17jwwj1yqb57x	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:12:11.358
cm3xvsnd200o77jwwffxqh98t	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:12:25.67
cm3xvta2k00o97jwwmhm8b7zn	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:12:55.1
cm3xvtpib00of7jwwoej48ydv	emman	User "Marlo Magdangal" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:15.107
cm3xvts6f00oj7jwwm5igktww	emman	User "Kyle Caballes" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:18.567
cm3xvtuiy00on7jwwpvdd1su6	emman	User "Jousheen Ly Salac" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:21.611
cm3xvtxk000or7jwwdi1r02of	emman	User "Miguel Co" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:25.537
cm3xvu03w00ov7jwwy2x3k5iv	emman	User "Kyle Tabla" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:28.844
cm3xvu37100oz7jwwfrfj1ux1	emman	User "Richard Jame Deano" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:32.845
cm3xvu5iy00p37jwwfl18247n	emman	User "Reanne Kevin Angcos" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:35.867
cm3xvu7pv00p77jwwhpqjmvgv	emman	User "Dutch der Linde" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:38.708
cm3xvuacu00pb7jwwf7u00ft3	emman	User "Bon Reparial" removed from designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:42.127
cm3xvulr400pf7jwwome78ahm	emman	User "Kyle Caballes" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:13:56.896
cm3xvuoxp00pl7jwwwesf82z9	emman	User "Marlo Magdangal" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:14:01.021
cm3xvv19x00pr7jww31wp161w	emman	User "Bon Reparial" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:14:17.013
cm3xvv94600px7jwwtb84x8dp	emman	User "Richard Jame Deano" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:14:27.175
cm3xvvo3900q37jwwk13ts57f	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:14:46.582
cm3xvw4bo00q57jwwyzuecwra	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:15:07.62
cm3xvwgw800qb7jwwzrmm1aqd	emman	User "Reanne Kevin Angcos" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:15:23.913
cm3xvx1li00qh7jwwpu4r8uc5	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:15:50.743
cm3xvxjtl00qj7jwwbs8qz8v7	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:16:14.362
cm3xvxz7400qp7jwwhvvaaix0	emman	User "Dutch der Linde" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:16:34.289
cm3xvz8jx00qt7jwwt4ov17nt	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:17:33.069
cm3xvz8km00r17jww5hd6uh6o	emman	User "Kyle Tabla" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:17:33.095
cm3xvzemf00r57jwwsiu5ix9d	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:17:40.935
cm3xvzen000rd7jww2a335n5d	emman	User "Miguel Co" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:17:40.956
cm3xw09ni00rh7jww5pw5rzdo	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:18:21.15
cm3xw09op00rp7jwwa9us40g4	emman	User "Jousheen Ly Salac" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 03:18:21.193
cm3xw1yql00rt7jww4k12urz2	emman	Designation Created by Admin: Emmanuel Diaz Aguado	2024-11-26 03:19:40.318
cm3xw6h4d00ry7jwwf3v1idjz	emman	Payroll generated for period 9/26/2024 to 10/10/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:23:10.765
cm3xw72kc00s17jwwurocay8g	emman	Payroll generated for period 10/11/2024 to 10/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:23:38.556
cm3xw7hv900s47jww3tr25f05	emman	Payroll generated for period 10/26/2024 to 11/10/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:23:58.389
cm3xw9znf02607jww5yxzwzsb	emman	Advanced Timesheet generation for multiple users by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:25:54.747
cm3xwa9re02b97jwwxwzm6zeo	emman	Employees added to Payroll by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:26:07.85
cm3xwaqby02gi7jwws2zpjroz	emman	Employees added to Payroll by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:26:29.326
cm3xwaysy02m07jwwtc7ujwkm	emman	Employees added to Payroll by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 03:26:40.307
cm3xwtdvs02m27jwwl4bzqi58	emman	User Log-Out	2024-11-26 03:40:59.655
cm3xwxkzp02m47jwwbw76uqgx	cm3xufw6p00k97jww8n9qq7fq	User Log-In	2024-11-26 03:44:15.493
cm3xwyeej02m67jwwafdn6rta	cm3xufw6p00k97jww8n9qq7fq	User Log-Out	2024-11-26 03:44:53.611
cm3xx153z02m87jwwivfwznp7	cm3xuoj8d00kv7jwwop9hwrrk	User Log-In	2024-11-26 03:47:01.536
cm3xx1nyj02ma7jwwr1dwfyax	cm3xuoj8d00kv7jwwop9hwrrk	User Log-Out	2024-11-26 03:47:25.951
cm3xx2qc302mc7jwwq9f72nbc	emman	User Log-In	2024-11-26 03:48:15.699
cm3xx9ic902me7jww01dbz2lo	emman	User Log-Out	2024-11-26 03:53:31.918
cm3xxakgs02mg7jwwwgg1s6j2	emman	User Log-In	2024-11-26 03:54:21.34
cm3xxglj702mk7jwwm098t40f	emman	User Timesheet Clock In	2024-11-26 03:59:02.659
cm3xxon2i02mo7jwwhkqb6d3y	emman	User requested VACATION leave from 2024-11-27 to 2024-11-29	2024-11-26 04:05:17.898
cm3xxrlvv02ms7jwww3kuqzed	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 04:07:36.331
cm3xxscji02qj7jww8nj2h0rp	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 04:08:10.878
cm3xxv79402qz7jww6lhv5ayu	emman	Increased salaries for departments cm3rieny30003uks91p9xxgq4 by $5000 by Super Admin: Emmanuel Diaz Aguado	2024-11-26 04:10:23.986
cm3xxynrh02r37jwwlx0mu0qq	emman	User "Reanne Kevin Angcos" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 04:13:05.357
cm3xyz1lw02r97jwwg9uodltq	emman	User Log-Out	2024-11-26 04:41:22.916
cm3xz0kry02rb7jwwo0vt3szj	emman	User Log-In	2024-11-26 04:42:34.415
cm3xz259r02rd7jww91h956s6	emman	User Log-Out	2024-11-26 04:43:47.63
cm3xz371p02rf7jwwxrytf023	emman	User Log-In	2024-11-26 04:44:36.589
cm3xzq8lv02rh7jww0z1kgqil	emman	User Log-Out	2024-11-26 05:02:31.698
cm3xzvxw702rj7jww00jfn0qd	emman	User Log-In	2024-11-26 05:06:57.751
cm3y0d50h02rn7jwwsle0zbv3	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 05:20:20.13
cm3y0dbw002vp7jww8yhaeuf4	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 05:20:29.04
cm3y0jnet02vx7jwwc43uubnf	emman	Increased salaries for departments cm3xvx1lh00qf7jwwz4ykdah7 by $1000 by Super Admin: Emmanuel Diaz Aguado	2024-11-26 05:25:23.909
cm3y0p32a02w17jwwb82v2so4	emman	User "Francis Paolo  Echavez" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 05:29:37.474
cm3y1aaww02w67jww9eu7ukzp	emman	User Log-Out	2024-11-26 05:46:07.424
cm3y1cgxg02w87jww8bqx3rpa	emman	User Log-In	2024-11-26 05:47:48.533
cm3y1dcfx02wa7jwwips68n7b	emman	User Log-Out	2024-11-26 05:48:29.373
cm3y1dh2i02wc7jwwzwtk6vgu	emman	User Log-In	2024-11-26 05:48:35.37
cm3y1e2j402we7jwwa7ola3qr	emman	User Log-Out	2024-11-26 05:49:03.184
cm3y1g79002wg7jwwd2dnfuhd	emman	User Log-In	2024-11-26 05:50:42.612
cm3y20hu402wi7jwwj2lvn444	emman	User Log-Out	2024-11-26 06:06:29.451
cm3y22gxa02wk7jww2yuo30dc	emman	User Log-In	2024-11-26 06:08:01.583
cm3y3nrrc000112cw6ljxh62t	emman	User Log-Out	2024-11-26 06:52:35.014
cm3y3r7tz000312cw1x4o28yk	emman	User Log-In	2024-11-26 06:55:15.816
cm3y4m2mx000512cwokwt7sqa	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 07:19:15.418
cm3y4mb67000712cwv79jypcz	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 07:19:26.479
cm3y4mhd7000912cw63guhlye	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 07:19:34.508
cm3y5nozr000f12cw6m8h3j3r	emman	Base salary edited for user emman from 5000 to 1000 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 07:48:30.664
cm3y5ohb1000l12cw3ccbdltl	emman	Base salary edited for user emman from 1000 to 5000 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 07:49:07.357
cm3y5ve13000111m23426fnzs	emman	User Log-In	2024-11-26 07:54:29.703
cm3y63mkv000711m2uues6dhx	emman	Base salary edited for user emman from 5000 to 6000 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 08:00:54.031
cm3y6y4kd000911m21vgzrvem	emman	User Log-Out	2024-11-26 08:24:37.021
cm3y7m9zs000b11m2yny29fuz	emman	User Log-In	2024-11-26 08:43:23.8
cm3y7q06u000m11m2d3apvcxv	emman	User "John Smith" Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 08:46:17.718
cm3y7squh000q11m2pr3fp7zl	emman	User Timesheet Clock In	2024-11-26 08:48:25.578
cm3y7ufkb000u11m2fj576q1q	emman	User requested SICK leave from 2024-11-28 to 2024-11-30	2024-11-26 08:49:44.268
cm3y7y86j000y11m22evkrcum	emman	Payroll Approved by: Emmanuel Diaz Aguado	2024-11-26 08:52:41.324
cm3y7yd7j005m11m2wfckjhwz	emman	Payroll generated for period 11/11/2024 to 11/25/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 08:52:47.839
cm3y80z8x005u11m2ejy7qc2h	emman	Increased salaries for departments cm3xvx1lh00qf7jwwz4ykdah7 by $5000 by Super Admin: Emmanuel Diaz Aguado	2024-11-26 08:54:49.712
cm3y84f6d005y11m22uqnglgn	emman	User "Jousheen Ly Salac" assigned to a designation by Admin: Emmanuel Diaz Aguado	2024-11-26 08:57:30.325
cm3y86r8l006411m2fla2cck8	emman	Department Created by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 08:59:19.27
cm3y8cods006611m2t86nb22k	emman	Department Updated by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 09:03:55.505
cm3y8ecrn006911m21oah2vfw	emman	Designation Updated by SUPERADMIN: Emmanuel Diaz Aguado	2024-11-26 09:05:13.764
cm3y8q57x006e11m2tzc8n4d4	emman	Payroll generated for period 12/31/2024 to 12/31/2024 by SuperAdmin: Emmanuel Diaz Aguado	2024-11-26 09:14:23.853
cm417fmxt000112askliyf2mq	emman	User Log-Out	2024-11-28 11:01:32.511
cm4cmdu7f0001z3vpfem1p5ut	emman	User Log-In	2024-12-06 10:45:30.795
\.


--
-- Data for Name: DaysNotWorked; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."DaysNotWorked" ("id", "date", "userId", "payrollItemId", "createdAt", "updatedAt") FROM stdin;
cm3xwayrp02l47jwwt4c58d25	2024-09-25 16:00:00	cm3sd6n7y000h98xyfpmb6any	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xwayrp02l57jwwqtwk873b	2024-09-26 16:00:00	cm3sd6n7y000h98xyfpmb6any	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xwayrp02l67jwweh9do3y9	2024-09-29 16:00:00	cm3sd6n7y000h98xyfpmb6any	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xways502li7jww7u2kfeba	2024-09-25 16:00:00	cm3sd5sob000698xytgsayvvu	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xways502lj7jwwpqwjkfpc	2024-09-26 16:00:00	cm3sd5sob000698xytgsayvvu	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xways502lk7jww9cvhpj1s	2024-09-29 16:00:00	cm3sd5sob000698xytgsayvvu	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xwaysx02lw7jwwy7ccergk	2024-09-25 16:00:00	emman	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3xwaysx02lx7jwwmqp9sex1	2024-09-26 16:00:00	emman	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3xwaysx02ly7jwwu2muyjdf	2024-09-29 16:00:00	emman	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
\.


--
-- Data for Name: Deductions; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Deductions" ("id", "userId", "deductionType", "amount", "description", "payrollItemId", "createdAt", "updatedAt") FROM stdin;
cm3xwa9jo02657jwwcxk6uf72	cm3xu8bx700jn7jwwlfh8k68g	SSS	495	SSS contribution	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:26:07.569	2024-11-26 03:26:07.569
cm3xwa9jo02677jww3vxbnc66	cm3xu8bx700jn7jwwlfh8k68g	PhilHealth	275	PhilHealth contribution	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:26:07.569	2024-11-26 03:26:07.569
cm3xwa9jo02697jwwnptkvttr	cm3xu8bx700jn7jwwlfh8k68g	PagIBIG	100	PagIBIG contribution	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:26:07.569	2024-11-26 03:26:07.569
cm3xwa9jo026b7jww4xjncquz	cm3xu8bx700jn7jwwlfh8k68g	Tax	0	Tax contribution	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:26:07.569	2024-11-26 03:26:07.569
cm3xwa9ka026g7jwwvbg18y34	cm3xuj38h00kk7jwwnwywtik2	SSS	1125	SSS contribution	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:26:07.593	2024-11-26 03:26:07.593
cm3xwa9kb026i7jwwf4kv5zvr	cm3xuj38h00kk7jwwnwywtik2	PhilHealth	1375	PhilHealth contribution	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:26:07.593	2024-11-26 03:26:07.593
cm3xwa9kb026k7jwwvvl7lpir	cm3xuj38h00kk7jwwnwywtik2	PagIBIG	100	PagIBIG contribution	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:26:07.593	2024-11-26 03:26:07.593
cm3xwa9kb026m7jww2hy4xl9a	cm3xuj38h00kk7jwwnwywtik2	Tax	6208.598	Tax contribution	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:26:07.593	2024-11-26 03:26:07.593
cm3xwa9kr026r7jwww8jg3ok9	cm3xud7bl00jy7jww9qzfi51c	SSS	1125	SSS contribution	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:26:07.61	2024-11-26 03:26:07.61
cm3xwa9kr026t7jwwcnegx6e0	cm3xud7bl00jy7jww9qzfi51c	PhilHealth	650	PhilHealth contribution	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:26:07.61	2024-11-26 03:26:07.61
cm3xwa9kr026v7jwwjglt988a	cm3xud7bl00jy7jww9qzfi51c	PagIBIG	100	PagIBIG contribution	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:26:07.61	2024-11-26 03:26:07.61
cm3xwa9kr026x7jwwj8c1mldo	cm3xud7bl00jy7jww9qzfi51c	Tax	775.0485000000002	Tax contribution	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:26:07.61	2024-11-26 03:26:07.61
cm3xwa9l702727jwwbh8m1bxg	cm3xuoj8d00kv7jwwop9hwrrk	SSS	1125	SSS contribution	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:26:07.626	2024-11-26 03:26:07.626
cm3xwa9l702747jwwruwwvm9q	cm3xuoj8d00kv7jwwop9hwrrk	PhilHealth	875	PhilHealth contribution	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:26:07.626	2024-11-26 03:26:07.626
cm3xwa9l702767jwwrb20mirj	cm3xuoj8d00kv7jwwop9hwrrk	PagIBIG	100	PagIBIG contribution	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:26:07.626	2024-11-26 03:26:07.626
cm3xwa9l702787jwwsko5ef4w	cm3xuoj8d00kv7jwwop9hwrrk	Tax	2208.598	Tax contribution	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:26:07.626	2024-11-26 03:26:07.626
cm3xwa9lm027d7jwwga2wq78x	cm3xufw6p00k97jww8n9qq7fq	SSS	1125	SSS contribution	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:26:07.641	2024-11-26 03:26:07.641
cm3xwa9lm027f7jwwn9m7sv8a	cm3xufw6p00k97jww8n9qq7fq	PhilHealth	775	PhilHealth contribution	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:26:07.641	2024-11-26 03:26:07.641
cm3xwa9lm027h7jwwwwbry51s	cm3xufw6p00k97jww8n9qq7fq	PagIBIG	100	PagIBIG contribution	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:26:07.641	2024-11-26 03:26:07.641
cm3xwa9lm027j7jwwq93acxx6	cm3xufw6p00k97jww8n9qq7fq	Tax	1525.0485	Tax contribution	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:26:07.641	2024-11-26 03:26:07.641
cm3xwa9m1027o7jwwdqtp5464	cm3xusu1p00l67jwwmm29up9j	SSS	1125	SSS contribution	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:26:07.656	2024-11-26 03:26:07.656
cm3xwa9m1027q7jwwmeeclmm5	cm3xusu1p00l67jwwmm29up9j	PhilHealth	625	PhilHealth contribution	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:26:07.656	2024-11-26 03:26:07.656
cm3xwa9m1027s7jwwb14w0me1	cm3xusu1p00l67jwwmm29up9j	PagIBIG	100	PagIBIG contribution	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:26:07.656	2024-11-26 03:26:07.656
cm3xwa9m1027u7jwwogaiiqkx	cm3xusu1p00l67jwwmm29up9j	Tax	625.0485000000002	Tax contribution	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:26:07.656	2024-11-26 03:26:07.656
cm3xwa9mi027z7jww8ha3ua9w	cm3xuz9oj00lh7jww07cy3cil	SSS	1125	SSS contribution	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:26:07.672	2024-11-26 03:26:07.672
cm3xwa9mi02817jww6na2hxxj	cm3xuz9oj00lh7jww07cy3cil	PhilHealth	1000	PhilHealth contribution	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:26:07.672	2024-11-26 03:26:07.672
cm3xwa9mi02837jww24rja2zu	cm3xuz9oj00lh7jww07cy3cil	PagIBIG	100	PagIBIG contribution	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:26:07.672	2024-11-26 03:26:07.672
cm3xwa9mi02857jwwqxqy4cag	cm3xuz9oj00lh7jww07cy3cil	Tax	3208.598	Tax contribution	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:26:07.672	2024-11-26 03:26:07.672
cm3xwa9mx028a7jwwfx5iajt3	cm3xv4w6000m37jww5tkffps0	SSS	1125	SSS contribution	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:26:07.688	2024-11-26 03:26:07.688
cm3xwa9mx028c7jwws89vwq1w	cm3xv4w6000m37jww5tkffps0	PhilHealth	1375	PhilHealth contribution	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:26:07.688	2024-11-26 03:26:07.688
cm3xwa9mx028e7jww22ikgsgg	cm3xv4w6000m37jww5tkffps0	PagIBIG	100	PagIBIG contribution	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:26:07.688	2024-11-26 03:26:07.688
cm3xwa9mx028g7jww3l6hvixk	cm3xv4w6000m37jww5tkffps0	Tax	6208.598	Tax contribution	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:26:07.688	2024-11-26 03:26:07.688
cm3xwa9nd028l7jwwjc4nlij3	cm3xvd52v00n07jwwu9txe547	SSS	1125	SSS contribution	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:26:07.704	2024-11-26 03:26:07.704
cm3xwa9nd028n7jwwrilo74ya	cm3xvd52v00n07jwwu9txe547	PhilHealth	875	PhilHealth contribution	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:26:07.704	2024-11-26 03:26:07.704
cm3xwa9nd028p7jwweu6mgj7a	cm3xvd52v00n07jwwu9txe547	PagIBIG	100	PagIBIG contribution	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:26:07.704	2024-11-26 03:26:07.704
cm3xwa9nd028r7jwww45uojl5	cm3xvd52v00n07jwwu9txe547	Tax	2208.598	Tax contribution	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:26:07.704	2024-11-26 03:26:07.704
cm3xwa9ns028w7jwwbacugyuq	cm3xv2tuq00ls7jwwsxzu6lcp	SSS	1125	SSS contribution	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:26:07.719	2024-11-26 03:26:07.719
cm3xwa9ns028y7jwwb3cdfe88	cm3xv2tuq00ls7jwwsxzu6lcp	PhilHealth	775	PhilHealth contribution	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:26:07.719	2024-11-26 03:26:07.719
cm3xwa9ns02907jww5c249tks	cm3xv2tuq00ls7jwwsxzu6lcp	PagIBIG	100	PagIBIG contribution	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:26:07.719	2024-11-26 03:26:07.719
cm3xwa9ns02927jww2q3lwm3g	cm3xv2tuq00ls7jwwsxzu6lcp	Tax	1525.0485	Tax contribution	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:26:07.719	2024-11-26 03:26:07.719
cm3xwa9o702977jwwpeq2563h	cm3xv6vyj00me7jww8fatnd46	SSS	1125	SSS contribution	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:26:07.734	2024-11-26 03:26:07.734
cm3xwa9o702997jwwgqi6ulr6	cm3xv6vyj00me7jww8fatnd46	PhilHealth	750	PhilHealth contribution	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:26:07.734	2024-11-26 03:26:07.734
cm3xwa9o8029b7jwwwahlcvsp	cm3xv6vyj00me7jww8fatnd46	PagIBIG	100	PagIBIG contribution	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:26:07.734	2024-11-26 03:26:07.734
cm3xwa9o8029d7jwwypfv51l8	cm3xv6vyj00me7jww8fatnd46	Tax	1375.0485	Tax contribution	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:26:07.734	2024-11-26 03:26:07.734
cm3xwa9ok029i7jww12ov7dff	cm3xvamu600mp7jwwmgb1kf5e	SSS	1125	SSS contribution	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:26:07.747	2024-11-26 03:26:07.747
cm3xwa9ok029k7jwweqgh4urh	cm3xvamu600mp7jwwmgb1kf5e	PhilHealth	2150	PhilHealth contribution	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:26:07.747	2024-11-26 03:26:07.747
cm3xwa9ok029m7jwwb3wijqdf	cm3xvamu600mp7jwwmgb1kf5e	PagIBIG	100	PagIBIG contribution	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:26:07.747	2024-11-26 03:26:07.747
cm3xwa9ol029o7jwwg3orw0cn	cm3xvamu600mp7jwwmgb1kf5e	Tax	13375.2975	Tax contribution	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:26:07.747	2024-11-26 03:26:07.747
cm3xwa9oz029t7jwwlt2osl05	cm3xvi9qr00nm7jwwmi7v4fru	SSS	1125	SSS contribution	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:26:07.76	2024-11-26 03:26:07.76
cm3xwa9oz029v7jww2va4x5fh	cm3xvi9qr00nm7jwwmi7v4fru	PhilHealth	875	PhilHealth contribution	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:26:07.76	2024-11-26 03:26:07.76
cm3xwa9oz029x7jww26t2v1ib	cm3xvi9qr00nm7jwwmi7v4fru	PagIBIG	100	PagIBIG contribution	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:26:07.76	2024-11-26 03:26:07.76
cm3xwa9oz029z7jwwplqsw3q7	cm3xvi9qr00nm7jwwmi7v4fru	Tax	2208.598	Tax contribution	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:26:07.76	2024-11-26 03:26:07.76
cm3xwa9pc02a47jwwhw3iijv2	cm3xvft2k00nb7jwwzijna876	SSS	900	SSS contribution	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:26:07.775	2024-11-26 03:26:07.775
cm3xwa9pc02a67jww6dfruj6o	cm3xvft2k00nb7jwwzijna876	PhilHealth	500	PhilHealth contribution	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:26:07.775	2024-11-26 03:26:07.775
cm3xwa9pc02a87jww6nrbsn5g	cm3xvft2k00nb7jwwzijna876	PagIBIG	100	PagIBIG contribution	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:26:07.775	2024-11-26 03:26:07.775
cm3xwa9pc02aa7jww9cuhg6g4	cm3xvft2k00nb7jwwzijna876	Tax	0	Tax contribution	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:26:07.775	2024-11-26 03:26:07.775
cm3xwa9q102af7jwwwn37ipk5	cm3sd6n7y000h98xyfpmb6any	SSS	495	SSS contribution	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 03:26:07.8	2024-11-26 03:26:07.8
cm3xwa9q102ah7jwwzhwe0mhg	cm3sd6n7y000h98xyfpmb6any	PhilHealth	275	PhilHealth contribution	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 03:26:07.8	2024-11-26 03:26:07.8
cm3xwa9q102aj7jwwsv7t2flf	cm3sd6n7y000h98xyfpmb6any	PagIBIG	100	PagIBIG contribution	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 03:26:07.8	2024-11-26 03:26:07.8
cm3xwa9q102al7jwwyo6agz8r	cm3sd6n7y000h98xyfpmb6any	Tax	0	Tax contribution	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 03:26:07.8	2024-11-26 03:26:07.8
cm3xwa9qk02aq7jwwtj6qs3cn	cm3sd5sob000698xytgsayvvu	SSS	495	SSS contribution	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 03:26:07.819	2024-11-26 03:26:07.819
cm3xwa9qk02as7jwwgak8qken	cm3sd5sob000698xytgsayvvu	PhilHealth	275	PhilHealth contribution	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 03:26:07.819	2024-11-26 03:26:07.819
cm3xwa9qk02au7jwwtckcb2kt	cm3sd5sob000698xytgsayvvu	PagIBIG	100	PagIBIG contribution	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 03:26:07.819	2024-11-26 03:26:07.819
cm3xwa9qk02aw7jwwhmqse94z	cm3sd5sob000698xytgsayvvu	Tax	0	Tax contribution	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 03:26:07.819	2024-11-26 03:26:07.819
cm3xwa9r502b17jww1a1eetyl	emman	SSS	495	SSS contribution	cm3xwa9r302az7jwwvm765rjf	2024-11-26 03:26:07.839	2024-11-26 03:26:07.839
cm3xwa9r502b37jww3zm4rt4x	emman	PhilHealth	275	PhilHealth contribution	cm3xwa9r302az7jwwvm765rjf	2024-11-26 03:26:07.839	2024-11-26 03:26:07.839
cm3xwa9r602b57jww935nlln4	emman	PagIBIG	100	PagIBIG contribution	cm3xwa9r302az7jwwvm765rjf	2024-11-26 03:26:07.839	2024-11-26 03:26:07.839
cm3xwa9r602b77jwwo9rf62gs	emman	Tax	0	Tax contribution	cm3xwa9r302az7jwwvm765rjf	2024-11-26 03:26:07.839	2024-11-26 03:26:07.839
cm3xwaq2k02be7jwwlzkt7tor	cm3xu8bx700jn7jwwlfh8k68g	SSS	495	SSS contribution	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:26:28.986	2024-11-26 03:26:28.986
cm3xwaq2k02bg7jwwrj8owy6u	cm3xu8bx700jn7jwwlfh8k68g	PhilHealth	275	PhilHealth contribution	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:26:28.986	2024-11-26 03:26:28.986
cm3xwaq2k02bi7jwwyqi72r3r	cm3xu8bx700jn7jwwlfh8k68g	PagIBIG	100	PagIBIG contribution	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:26:28.986	2024-11-26 03:26:28.986
cm3xwaq2k02bk7jwwcz8f9zt3	cm3xu8bx700jn7jwwlfh8k68g	Tax	0	Tax contribution	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:26:28.986	2024-11-26 03:26:28.986
cm3xwaq3202bp7jww0bzfk8wv	cm3xuj38h00kk7jwwnwywtik2	SSS	1125	SSS contribution	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:26:29.005	2024-11-26 03:26:29.005
cm3xwaq3202br7jww1p3z5h6i	cm3xuj38h00kk7jwwnwywtik2	PhilHealth	1375	PhilHealth contribution	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:26:29.005	2024-11-26 03:26:29.005
cm3xwaq3302bt7jwwij33ubck	cm3xuj38h00kk7jwwnwywtik2	PagIBIG	100	PagIBIG contribution	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:26:29.005	2024-11-26 03:26:29.005
cm3xwaq3302bv7jwwwy1q2z7m	cm3xuj38h00kk7jwwnwywtik2	Tax	6208.598	Tax contribution	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:26:29.005	2024-11-26 03:26:29.005
cm3xwaq3h02c07jww38jxubkc	cm3xud7bl00jy7jww9qzfi51c	SSS	1125	SSS contribution	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:26:29.02	2024-11-26 03:26:29.02
cm3xwaq3h02c27jwweqwkt5e0	cm3xud7bl00jy7jww9qzfi51c	PhilHealth	650	PhilHealth contribution	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:26:29.02	2024-11-26 03:26:29.02
cm3xwaq3h02c47jwwzi4wbc7q	cm3xud7bl00jy7jww9qzfi51c	PagIBIG	100	PagIBIG contribution	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:26:29.02	2024-11-26 03:26:29.02
cm3xwaq3h02c67jww86u62eob	cm3xud7bl00jy7jww9qzfi51c	Tax	775.0485000000002	Tax contribution	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:26:29.02	2024-11-26 03:26:29.02
cm3xwaq3v02cb7jwwqd1xb5qz	cm3xuoj8d00kv7jwwop9hwrrk	SSS	1125	SSS contribution	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:26:29.034	2024-11-26 03:26:29.034
cm3xwaq3v02cd7jww0sjl8qev	cm3xuoj8d00kv7jwwop9hwrrk	PhilHealth	875	PhilHealth contribution	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:26:29.034	2024-11-26 03:26:29.034
cm3xwaq3v02cf7jwwtrjvduo9	cm3xuoj8d00kv7jwwop9hwrrk	PagIBIG	100	PagIBIG contribution	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:26:29.034	2024-11-26 03:26:29.034
cm3xwaq3v02ch7jww27ug7hw4	cm3xuoj8d00kv7jwwop9hwrrk	Tax	2208.598	Tax contribution	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:26:29.034	2024-11-26 03:26:29.034
cm3xwaq4a02cm7jwwpyrh13ta	cm3xufw6p00k97jww8n9qq7fq	SSS	1125	SSS contribution	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:26:29.047	2024-11-26 03:26:29.047
cm3xwaq4a02co7jwwt8vmmzem	cm3xufw6p00k97jww8n9qq7fq	PhilHealth	775	PhilHealth contribution	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:26:29.047	2024-11-26 03:26:29.047
cm3xwaq4a02cq7jwwem6w0c63	cm3xufw6p00k97jww8n9qq7fq	PagIBIG	100	PagIBIG contribution	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:26:29.047	2024-11-26 03:26:29.047
cm3xwaq4a02cs7jwwnlv2wtpn	cm3xufw6p00k97jww8n9qq7fq	Tax	1525.0485	Tax contribution	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:26:29.047	2024-11-26 03:26:29.047
cm3xwaq4n02cx7jwwyka7ppai	cm3xusu1p00l67jwwmm29up9j	SSS	1125	SSS contribution	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:26:29.062	2024-11-26 03:26:29.062
cm3xwaq4o02cz7jww4yaf383y	cm3xusu1p00l67jwwmm29up9j	PhilHealth	625	PhilHealth contribution	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:26:29.062	2024-11-26 03:26:29.062
cm3xwaq4o02d17jwwvyvddhtr	cm3xusu1p00l67jwwmm29up9j	PagIBIG	100	PagIBIG contribution	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:26:29.062	2024-11-26 03:26:29.062
cm3xwaq4o02d37jwws3qvny18	cm3xusu1p00l67jwwmm29up9j	Tax	625.0485000000002	Tax contribution	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:26:29.062	2024-11-26 03:26:29.062
cm3xwaq5202d87jwwq2qm0n3s	cm3xuz9oj00lh7jww07cy3cil	SSS	1125	SSS contribution	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:26:29.077	2024-11-26 03:26:29.077
cm3xwaq5202da7jww7384liqb	cm3xuz9oj00lh7jww07cy3cil	PhilHealth	1000	PhilHealth contribution	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:26:29.077	2024-11-26 03:26:29.077
cm3xwaq5202dc7jwwou6lvdfv	cm3xuz9oj00lh7jww07cy3cil	PagIBIG	100	PagIBIG contribution	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:26:29.077	2024-11-26 03:26:29.077
cm3xwaq5202de7jwwtk531i6q	cm3xuz9oj00lh7jww07cy3cil	Tax	3208.598	Tax contribution	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:26:29.077	2024-11-26 03:26:29.077
cm3xwaq5i02dj7jwwjuk4smwm	cm3xv4w6000m37jww5tkffps0	SSS	1125	SSS contribution	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:26:29.092	2024-11-26 03:26:29.092
cm3xwaq5i02dl7jwwf72z3qjv	cm3xv4w6000m37jww5tkffps0	PhilHealth	1375	PhilHealth contribution	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:26:29.092	2024-11-26 03:26:29.092
cm3xwaq5i02dn7jwwqei9g2zx	cm3xv4w6000m37jww5tkffps0	PagIBIG	100	PagIBIG contribution	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:26:29.092	2024-11-26 03:26:29.092
cm3xwaq5i02dp7jww1p7vmadh	cm3xv4w6000m37jww5tkffps0	Tax	6208.598	Tax contribution	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:26:29.092	2024-11-26 03:26:29.092
cm3xwaq5x02du7jwwzuokees2	cm3xvd52v00n07jwwu9txe547	SSS	1125	SSS contribution	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:26:29.108	2024-11-26 03:26:29.108
cm3xwaq5x02dw7jww3ykiar1f	cm3xvd52v00n07jwwu9txe547	PhilHealth	875	PhilHealth contribution	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:26:29.108	2024-11-26 03:26:29.108
cm3xwaq5x02dy7jww7152j0le	cm3xvd52v00n07jwwu9txe547	PagIBIG	100	PagIBIG contribution	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:26:29.108	2024-11-26 03:26:29.108
cm3xwaq5x02e07jwwdcyix1vz	cm3xvd52v00n07jwwu9txe547	Tax	2208.598	Tax contribution	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:26:29.108	2024-11-26 03:26:29.108
cm3xwaq7p02e57jwwnze8dev9	cm3xv2tuq00ls7jwwsxzu6lcp	SSS	1125	SSS contribution	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:26:29.171	2024-11-26 03:26:29.171
cm3xwaq7p02e77jwwg30qk84h	cm3xv2tuq00ls7jwwsxzu6lcp	PhilHealth	775	PhilHealth contribution	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:26:29.171	2024-11-26 03:26:29.171
cm3xwaq7p02e97jwwhwbcgfhz	cm3xv2tuq00ls7jwwsxzu6lcp	PagIBIG	100	PagIBIG contribution	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:26:29.171	2024-11-26 03:26:29.171
cm3xwaq7q02eb7jww04uucfr6	cm3xv2tuq00ls7jwwsxzu6lcp	Tax	1525.0485	Tax contribution	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:26:29.171	2024-11-26 03:26:29.171
cm3xwaq8j02eg7jwwsu765pm4	cm3xv6vyj00me7jww8fatnd46	SSS	1125	SSS contribution	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:26:29.201	2024-11-26 03:26:29.201
cm3xwaq8j02ei7jwwxqmitu0m	cm3xv6vyj00me7jww8fatnd46	PhilHealth	750	PhilHealth contribution	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:26:29.201	2024-11-26 03:26:29.201
cm3xwaq8j02ek7jwwc4a9k94o	cm3xv6vyj00me7jww8fatnd46	PagIBIG	100	PagIBIG contribution	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:26:29.201	2024-11-26 03:26:29.201
cm3xwaq8j02em7jwwxxpmukhb	cm3xv6vyj00me7jww8fatnd46	Tax	1375.0485	Tax contribution	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:26:29.201	2024-11-26 03:26:29.201
cm3xwaq9c02er7jwwx3smjukv	cm3xvamu600mp7jwwmgb1kf5e	SSS	1125	SSS contribution	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:26:29.23	2024-11-26 03:26:29.23
cm3xwaq9c02et7jwwstherhnt	cm3xvamu600mp7jwwmgb1kf5e	PhilHealth	2150	PhilHealth contribution	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:26:29.23	2024-11-26 03:26:29.23
cm3xwaq9c02ev7jwwsuglwg6w	cm3xvamu600mp7jwwmgb1kf5e	PagIBIG	100	PagIBIG contribution	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:26:29.23	2024-11-26 03:26:29.23
cm3xwaq9c02ex7jwwq8s90jyc	cm3xvamu600mp7jwwmgb1kf5e	Tax	13375.2975	Tax contribution	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:26:29.23	2024-11-26 03:26:29.23
cm3xwaq9q02f27jwwvkyoi1kk	cm3xvi9qr00nm7jwwmi7v4fru	SSS	1125	SSS contribution	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:26:29.245	2024-11-26 03:26:29.245
cm3xwaq9q02f47jwwfohspsj1	cm3xvi9qr00nm7jwwmi7v4fru	PhilHealth	875	PhilHealth contribution	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:26:29.245	2024-11-26 03:26:29.245
cm3xwaq9q02f67jwwbpazrux2	cm3xvi9qr00nm7jwwmi7v4fru	PagIBIG	100	PagIBIG contribution	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:26:29.245	2024-11-26 03:26:29.245
cm3xwaq9r02f87jww42hsmivw	cm3xvi9qr00nm7jwwmi7v4fru	Tax	2208.598	Tax contribution	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:26:29.245	2024-11-26 03:26:29.245
cm3xwaqa402fd7jwwbhfmdv7x	cm3xvft2k00nb7jwwzijna876	SSS	900	SSS contribution	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:26:29.259	2024-11-26 03:26:29.259
cm3xwaqa402ff7jwwtmgtjanu	cm3xvft2k00nb7jwwzijna876	PhilHealth	500	PhilHealth contribution	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:26:29.259	2024-11-26 03:26:29.259
cm3xwaqa402fh7jwwg3jne5j3	cm3xvft2k00nb7jwwzijna876	PagIBIG	100	PagIBIG contribution	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:26:29.259	2024-11-26 03:26:29.259
cm3xwaqa502fj7jwwm2646tf6	cm3xvft2k00nb7jwwzijna876	Tax	0	Tax contribution	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:26:29.259	2024-11-26 03:26:29.259
cm3xwaqax02fo7jwwpad2n2vi	cm3sd6n7y000h98xyfpmb6any	SSS	495	SSS contribution	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 03:26:29.287	2024-11-26 03:26:29.287
cm3xwaqax02fq7jwwxpmx72va	cm3sd6n7y000h98xyfpmb6any	PhilHealth	275	PhilHealth contribution	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 03:26:29.287	2024-11-26 03:26:29.287
cm3xwaqax02fs7jwwsdcqn5wy	cm3sd6n7y000h98xyfpmb6any	PagIBIG	100	PagIBIG contribution	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 03:26:29.287	2024-11-26 03:26:29.287
cm3xwaqax02fu7jwwcmcv0q6q	cm3sd6n7y000h98xyfpmb6any	Tax	0	Tax contribution	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 03:26:29.287	2024-11-26 03:26:29.287
cm3xwaqbd02fz7jwwqeeasoi7	cm3sd5sob000698xytgsayvvu	SSS	495	SSS contribution	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 03:26:29.304	2024-11-26 03:26:29.304
cm3xwaqbd02g17jwwjt7tybzp	cm3sd5sob000698xytgsayvvu	PhilHealth	275	PhilHealth contribution	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 03:26:29.304	2024-11-26 03:26:29.304
cm3xwaqbd02g37jwwki3ajh9x	cm3sd5sob000698xytgsayvvu	PagIBIG	100	PagIBIG contribution	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 03:26:29.304	2024-11-26 03:26:29.304
cm3xwaqbd02g57jwwirjbvjgv	cm3sd5sob000698xytgsayvvu	Tax	0	Tax contribution	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 03:26:29.304	2024-11-26 03:26:29.304
cm3xwaqbu02ga7jwwazya4xl2	emman	SSS	495	SSS contribution	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 03:26:29.32	2024-11-26 03:26:29.32
cm3xwaqbu02gc7jww62onxcgf	emman	PhilHealth	275	PhilHealth contribution	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 03:26:29.32	2024-11-26 03:26:29.32
cm3xwaqbu02ge7jww9v8acyqh	emman	PagIBIG	100	PagIBIG contribution	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 03:26:29.32	2024-11-26 03:26:29.32
cm3xwaqbu02gg7jww02japt5h	emman	Tax	0	Tax contribution	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 03:26:29.32	2024-11-26 03:26:29.32
cm3xwaylj02gn7jwwaudd19hr	cm3xu8bx700jn7jwwlfh8k68g	SSS	495	SSS contribution	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:26:40.037	2024-11-26 03:26:40.037
cm3xwaylj02gp7jwwi7f8xl0i	cm3xu8bx700jn7jwwlfh8k68g	PhilHealth	275	PhilHealth contribution	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:26:40.037	2024-11-26 03:26:40.037
cm3xwaylj02gr7jwwtkv3lr3d	cm3xu8bx700jn7jwwlfh8k68g	PagIBIG	100	PagIBIG contribution	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:26:40.037	2024-11-26 03:26:40.037
cm3xwaylj02gt7jww4s4p9qto	cm3xu8bx700jn7jwwlfh8k68g	Tax	0	Tax contribution	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:26:40.037	2024-11-26 03:26:40.037
cm3xwaym602gy7jwww8d2vjdd	cm3xuj38h00kk7jwwnwywtik2	SSS	1125	SSS contribution	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:26:40.061	2024-11-26 03:26:40.061
cm3xwaym602h07jwwwpe755g0	cm3xuj38h00kk7jwwnwywtik2	PhilHealth	1375	PhilHealth contribution	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:26:40.061	2024-11-26 03:26:40.061
cm3xwaym702h27jww72y9eluo	cm3xuj38h00kk7jwwnwywtik2	PagIBIG	100	PagIBIG contribution	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:26:40.061	2024-11-26 03:26:40.061
cm3xwaym702h47jww8l90j872	cm3xuj38h00kk7jwwnwywtik2	Tax	6208.598	Tax contribution	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:26:40.061	2024-11-26 03:26:40.061
cm3xwaymk02h97jwwvdd92kjw	cm3xud7bl00jy7jww9qzfi51c	SSS	1125	SSS contribution	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:26:40.075	2024-11-26 03:26:40.075
cm3xwaymk02hb7jwwnteygcqc	cm3xud7bl00jy7jww9qzfi51c	PhilHealth	650	PhilHealth contribution	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:26:40.075	2024-11-26 03:26:40.075
cm3xwaymk02hd7jwwq9gj7htf	cm3xud7bl00jy7jww9qzfi51c	PagIBIG	100	PagIBIG contribution	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:26:40.075	2024-11-26 03:26:40.075
cm3xwaymk02hf7jww57i18r6f	cm3xud7bl00jy7jww9qzfi51c	Tax	775.0485000000002	Tax contribution	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:26:40.075	2024-11-26 03:26:40.075
cm3xwaymy02hk7jww4mrydy4u	cm3xuoj8d00kv7jwwop9hwrrk	SSS	1125	SSS contribution	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:26:40.089	2024-11-26 03:26:40.089
cm3xwaymy02hm7jww09in9av6	cm3xuoj8d00kv7jwwop9hwrrk	PhilHealth	875	PhilHealth contribution	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:26:40.089	2024-11-26 03:26:40.089
cm3xwaymy02ho7jww7ypab9wm	cm3xuoj8d00kv7jwwop9hwrrk	PagIBIG	100	PagIBIG contribution	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:26:40.089	2024-11-26 03:26:40.089
cm3xwaymy02hq7jwwug6toxnz	cm3xuoj8d00kv7jwwop9hwrrk	Tax	2208.598	Tax contribution	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:26:40.089	2024-11-26 03:26:40.089
cm3xwaynd02hv7jwwg4preio4	cm3xufw6p00k97jww8n9qq7fq	SSS	1125	SSS contribution	cm3xwaync02ht7jwws7vif268	2024-11-26 03:26:40.103	2024-11-26 03:26:40.103
cm3xwaynd02hx7jww7qpwa57a	cm3xufw6p00k97jww8n9qq7fq	PhilHealth	775	PhilHealth contribution	cm3xwaync02ht7jwws7vif268	2024-11-26 03:26:40.103	2024-11-26 03:26:40.103
cm3xwaynd02hz7jww7gtvvwm7	cm3xufw6p00k97jww8n9qq7fq	PagIBIG	100	PagIBIG contribution	cm3xwaync02ht7jwws7vif268	2024-11-26 03:26:40.103	2024-11-26 03:26:40.103
cm3xwaynd02i17jww10tse2ra	cm3xufw6p00k97jww8n9qq7fq	Tax	1525.0485	Tax contribution	cm3xwaync02ht7jwws7vif268	2024-11-26 03:26:40.103	2024-11-26 03:26:40.103
cm3xwaynr02i67jwwxssw9svu	cm3xusu1p00l67jwwmm29up9j	SSS	1125	SSS contribution	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:26:40.118	2024-11-26 03:26:40.118
cm3xwaynr02i87jww1qh8cypk	cm3xusu1p00l67jwwmm29up9j	PhilHealth	625	PhilHealth contribution	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:26:40.118	2024-11-26 03:26:40.118
cm3xwayns02ia7jwwbxawye7o	cm3xusu1p00l67jwwmm29up9j	PagIBIG	100	PagIBIG contribution	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:26:40.118	2024-11-26 03:26:40.118
cm3xwayns02ic7jwwup9lgj2r	cm3xusu1p00l67jwwmm29up9j	Tax	625.0485000000002	Tax contribution	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:26:40.118	2024-11-26 03:26:40.118
cm3xwayo602ih7jww7cj6zunj	cm3xuz9oj00lh7jww07cy3cil	SSS	1125	SSS contribution	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:26:40.133	2024-11-26 03:26:40.133
cm3xwayo602ij7jwwvga4x1z6	cm3xuz9oj00lh7jww07cy3cil	PhilHealth	1000	PhilHealth contribution	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:26:40.133	2024-11-26 03:26:40.133
cm3xwayo602il7jwwdf18polt	cm3xuz9oj00lh7jww07cy3cil	PagIBIG	100	PagIBIG contribution	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:26:40.133	2024-11-26 03:26:40.133
cm3xwayo602in7jww7r6dkf2p	cm3xuz9oj00lh7jww07cy3cil	Tax	3208.598	Tax contribution	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:26:40.133	2024-11-26 03:26:40.133
cm3xwayol02is7jww11b7sgp4	cm3xv4w6000m37jww5tkffps0	SSS	1125	SSS contribution	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:26:40.147	2024-11-26 03:26:40.147
cm3xwayol02iu7jwwy93ojpnx	cm3xv4w6000m37jww5tkffps0	PhilHealth	1375	PhilHealth contribution	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:26:40.147	2024-11-26 03:26:40.147
cm3xwayol02iw7jwwmtgiultd	cm3xv4w6000m37jww5tkffps0	PagIBIG	100	PagIBIG contribution	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:26:40.147	2024-11-26 03:26:40.147
cm3xwayol02iy7jwwm36eetvm	cm3xv4w6000m37jww5tkffps0	Tax	6208.598	Tax contribution	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:26:40.147	2024-11-26 03:26:40.147
cm3xwayp002j37jwwbpaxcyip	cm3xvd52v00n07jwwu9txe547	SSS	1125	SSS contribution	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:26:40.162	2024-11-26 03:26:40.162
cm3xwayp002j57jww47tlzvd0	cm3xvd52v00n07jwwu9txe547	PhilHealth	875	PhilHealth contribution	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:26:40.162	2024-11-26 03:26:40.162
cm3xwayp002j77jww0oqx7tek	cm3xvd52v00n07jwwu9txe547	PagIBIG	100	PagIBIG contribution	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:26:40.162	2024-11-26 03:26:40.162
cm3xwayp002j97jww904fhu1k	cm3xvd52v00n07jwwu9txe547	Tax	2208.598	Tax contribution	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:26:40.162	2024-11-26 03:26:40.162
cm3xwaypf02je7jwwmr2z078v	cm3xv2tuq00ls7jwwsxzu6lcp	SSS	1125	SSS contribution	cm3xwaype02jc7jww7028frj5	2024-11-26 03:26:40.178	2024-11-26 03:26:40.178
cm3xwaypf02jg7jwwshyl2pel	cm3xv2tuq00ls7jwwsxzu6lcp	PhilHealth	775	PhilHealth contribution	cm3xwaype02jc7jww7028frj5	2024-11-26 03:26:40.178	2024-11-26 03:26:40.178
cm3xwaypf02ji7jww9bhs1m1l	cm3xv2tuq00ls7jwwsxzu6lcp	PagIBIG	100	PagIBIG contribution	cm3xwaype02jc7jww7028frj5	2024-11-26 03:26:40.178	2024-11-26 03:26:40.178
cm3xwaypf02jk7jwwvhb9gbwv	cm3xv2tuq00ls7jwwsxzu6lcp	Tax	1525.0485	Tax contribution	cm3xwaype02jc7jww7028frj5	2024-11-26 03:26:40.178	2024-11-26 03:26:40.178
cm3xwaypu02jp7jww47q78k2a	cm3xv6vyj00me7jww8fatnd46	SSS	1125	SSS contribution	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:26:40.192	2024-11-26 03:26:40.192
cm3xwaypu02jr7jwwlqbgux45	cm3xv6vyj00me7jww8fatnd46	PhilHealth	750	PhilHealth contribution	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:26:40.192	2024-11-26 03:26:40.192
cm3xwaypu02jt7jww6155yla3	cm3xv6vyj00me7jww8fatnd46	PagIBIG	100	PagIBIG contribution	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:26:40.192	2024-11-26 03:26:40.192
cm3xwaypu02jv7jww8kdvam6k	cm3xv6vyj00me7jww8fatnd46	Tax	1375.0485	Tax contribution	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:26:40.192	2024-11-26 03:26:40.192
cm3xwayqc02k07jwwz7wh47kh	cm3xvamu600mp7jwwmgb1kf5e	SSS	1125	SSS contribution	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:26:40.21	2024-11-26 03:26:40.21
cm3xwayqc02k27jwwtrusqi9a	cm3xvamu600mp7jwwmgb1kf5e	PhilHealth	2150	PhilHealth contribution	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:26:40.21	2024-11-26 03:26:40.21
cm3xwayqc02k47jwwqfczt1jh	cm3xvamu600mp7jwwmgb1kf5e	PagIBIG	100	PagIBIG contribution	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:26:40.21	2024-11-26 03:26:40.21
cm3xwayqc02k67jwws53v4ltx	cm3xvamu600mp7jwwmgb1kf5e	Tax	13375.2975	Tax contribution	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:26:40.21	2024-11-26 03:26:40.21
cm3xwayqr02kb7jww8qiruh18	cm3xvi9qr00nm7jwwmi7v4fru	SSS	1125	SSS contribution	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:26:40.225	2024-11-26 03:26:40.225
cm3xwayqr02kd7jwwz7s7fc8l	cm3xvi9qr00nm7jwwmi7v4fru	PhilHealth	875	PhilHealth contribution	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:26:40.225	2024-11-26 03:26:40.225
cm3xwayqr02kf7jwwdax7l2oq	cm3xvi9qr00nm7jwwmi7v4fru	PagIBIG	100	PagIBIG contribution	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:26:40.225	2024-11-26 03:26:40.225
cm3xwayqr02kh7jwwjthn36m8	cm3xvi9qr00nm7jwwmi7v4fru	Tax	2208.598	Tax contribution	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:26:40.225	2024-11-26 03:26:40.225
cm3xwayr502km7jww8mf13iel	cm3xvft2k00nb7jwwzijna876	SSS	900	SSS contribution	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:26:40.24	2024-11-26 03:26:40.24
cm3xwayr502ko7jwwzbmv9oxr	cm3xvft2k00nb7jwwzijna876	PhilHealth	500	PhilHealth contribution	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:26:40.24	2024-11-26 03:26:40.24
cm3xwayr502kq7jwwqhjw51ma	cm3xvft2k00nb7jwwzijna876	PagIBIG	100	PagIBIG contribution	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:26:40.24	2024-11-26 03:26:40.24
cm3xwayr502ks7jwwnmk7pglw	cm3xvft2k00nb7jwwzijna876	Tax	0	Tax contribution	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:26:40.24	2024-11-26 03:26:40.24
cm3xwayrl02kx7jwwgs218fff	cm3sd6n7y000h98xyfpmb6any	SSS	495	SSS contribution	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xwayrl02kz7jww0dowjrui	cm3sd6n7y000h98xyfpmb6any	PhilHealth	275	PhilHealth contribution	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xwayrl02l17jwwtnfdzyt8	cm3sd6n7y000h98xyfpmb6any	PagIBIG	100	PagIBIG contribution	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xwayrl02l37jwwmsf0kqlk	cm3sd6n7y000h98xyfpmb6any	Tax	0	Tax contribution	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xways202lb7jwwkkfeiieo	cm3sd5sob000698xytgsayvvu	SSS	495	SSS contribution	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xways202ld7jwwp0yb22lz	cm3sd5sob000698xytgsayvvu	PhilHealth	275	PhilHealth contribution	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xways202lf7jww0h4vb7o7	cm3sd5sob000698xytgsayvvu	PagIBIG	100	PagIBIG contribution	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xways202lh7jwwkggcjge2	cm3sd5sob000698xytgsayvvu	Tax	0	Tax contribution	cm3xways102l97jwwcr64dd2o	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xwaysi02lp7jww67la8qvy	emman	SSS	495	SSS contribution	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3xwaysi02lr7jwwnzkgtpe9	emman	PhilHealth	275	PhilHealth contribution	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3xwaysi02lt7jwwsa7nnwck	emman	PagIBIG	100	PagIBIG contribution	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3xwaysi02lv7jwwi9bgyigx	emman	Tax	0	Tax contribution	cm3xwaysh02ln7jwwbif5piag	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3y7yd6k004611m2s4abo7gx	cm3sd6n7y000h98xyfpmb6any	SSS	720	SSS contribution	cm3y7yd6j004411m2fi06w93m	2024-11-26 08:52:47.803	2024-11-26 08:52:47.803
cm3y7yd6y004s11m2g23063xj	cm3xu8bx700jn7jwwlfh8k68g	SSS	720	SSS contribution	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 08:52:47.817	2024-11-26 08:52:47.817
cm3y7yd42001411m21ue1yul0	cm3y7pz20000d11m2522rpsoa	SSS	1125	SSS contribution	cm3y7yd3y001211m2thni63rn	2024-11-26 08:52:47.71	2024-11-26 08:52:47.71
cm3y7yd42001611m2fhthtwuy	cm3y7pz20000d11m2522rpsoa	PhilHealth	625	PhilHealth contribution	cm3y7yd3y001211m2thni63rn	2024-11-26 08:52:47.71	2024-11-26 08:52:47.71
cm3y7yd42001811m2xf6wti5h	cm3y7pz20000d11m2522rpsoa	PagIBIG	100	PagIBIG contribution	cm3y7yd3y001211m2thni63rn	2024-11-26 08:52:47.71	2024-11-26 08:52:47.71
cm3y7yd42001a11m2uwuf6kmk	cm3y7pz20000d11m2522rpsoa	Tax	625.0485000000002	Tax contribution	cm3y7yd3y001211m2thni63rn	2024-11-26 08:52:47.71	2024-11-26 08:52:47.71
cm3y7yd4b001f11m23ug8itfj	cm3xv2tuq00ls7jwwsxzu6lcp	SSS	1125	SSS contribution	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 08:52:47.722	2024-11-26 08:52:47.722
cm3y7yd4b001h11m2487c1s1v	cm3xv2tuq00ls7jwwsxzu6lcp	PhilHealth	775	PhilHealth contribution	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 08:52:47.722	2024-11-26 08:52:47.722
cm3y7yd4b001j11m2r440pwx8	cm3xv2tuq00ls7jwwsxzu6lcp	PagIBIG	100	PagIBIG contribution	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 08:52:47.722	2024-11-26 08:52:47.722
cm3y7yd4c001l11m2ojo0ajam	cm3xv2tuq00ls7jwwsxzu6lcp	Tax	1525.0485	Tax contribution	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 08:52:47.722	2024-11-26 08:52:47.722
cm3y7yd4k001q11m2wl73t1mo	cm3xvd52v00n07jwwu9txe547	SSS	1125	SSS contribution	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 08:52:47.731	2024-11-26 08:52:47.731
cm3y7yd4k001s11m2qrfcy5kz	cm3xvd52v00n07jwwu9txe547	PhilHealth	875	PhilHealth contribution	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 08:52:47.731	2024-11-26 08:52:47.731
cm3y7yd4k001u11m2n3y8lubc	cm3xvd52v00n07jwwu9txe547	PagIBIG	100	PagIBIG contribution	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 08:52:47.731	2024-11-26 08:52:47.731
cm3y7yd4k001w11m2sjah2ke7	cm3xvd52v00n07jwwu9txe547	Tax	2208.598	Tax contribution	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 08:52:47.731	2024-11-26 08:52:47.731
cm3y7yd4s002111m28et1u48r	cm3xvamu600mp7jwwmgb1kf5e	SSS	1125	SSS contribution	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 08:52:47.739	2024-11-26 08:52:47.739
cm3y7yd4s002311m2eta0ddnz	cm3xvamu600mp7jwwmgb1kf5e	PhilHealth	2150	PhilHealth contribution	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 08:52:47.739	2024-11-26 08:52:47.739
cm3y7yd4s002511m2e9803s01	cm3xvamu600mp7jwwmgb1kf5e	PagIBIG	100	PagIBIG contribution	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 08:52:47.739	2024-11-26 08:52:47.739
cm3y7yd4s002711m2lanl1ssz	cm3xvamu600mp7jwwmgb1kf5e	Tax	13375.2975	Tax contribution	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 08:52:47.739	2024-11-26 08:52:47.739
cm3y7yd51002c11m2pqv3wq78	cm3xuoj8d00kv7jwwop9hwrrk	SSS	1125	SSS contribution	cm3y7yd4z002a11m20u8h9422	2024-11-26 08:52:47.747	2024-11-26 08:52:47.747
cm3y7yd51002e11m2pfifiks8	cm3xuoj8d00kv7jwwop9hwrrk	PhilHealth	875	PhilHealth contribution	cm3y7yd4z002a11m20u8h9422	2024-11-26 08:52:47.747	2024-11-26 08:52:47.747
cm3y7yd51002g11m2vhyls36f	cm3xuoj8d00kv7jwwop9hwrrk	PagIBIG	100	PagIBIG contribution	cm3y7yd4z002a11m20u8h9422	2024-11-26 08:52:47.747	2024-11-26 08:52:47.747
cm3y7yd51002i11m24drucgzl	cm3xuoj8d00kv7jwwop9hwrrk	Tax	2208.598	Tax contribution	cm3y7yd4z002a11m20u8h9422	2024-11-26 08:52:47.747	2024-11-26 08:52:47.747
cm3y7yd5a002n11m2pam5s9xb	cm3xud7bl00jy7jww9qzfi51c	SSS	1125	SSS contribution	cm3y7yd59002l11m2caqkukyt	2024-11-26 08:52:47.757	2024-11-26 08:52:47.757
cm3y7yd5a002p11m2g07wz95o	cm3xud7bl00jy7jww9qzfi51c	PhilHealth	775	PhilHealth contribution	cm3y7yd59002l11m2caqkukyt	2024-11-26 08:52:47.757	2024-11-26 08:52:47.757
cm3y7yd5a002r11m2fm32xib0	cm3xud7bl00jy7jww9qzfi51c	PagIBIG	100	PagIBIG contribution	cm3y7yd59002l11m2caqkukyt	2024-11-26 08:52:47.757	2024-11-26 08:52:47.757
cm3y7yd5a002t11m2ua6j0sgp	cm3xud7bl00jy7jww9qzfi51c	Tax	1525.0485	Tax contribution	cm3y7yd59002l11m2caqkukyt	2024-11-26 08:52:47.757	2024-11-26 08:52:47.757
cm3y7yd5j002y11m2oj5g6p0p	cm3xv6vyj00me7jww8fatnd46	SSS	1125	SSS contribution	cm3y7yd5g002w11m27ady5dhp	2024-11-26 08:52:47.764	2024-11-26 08:52:47.764
cm3y7yd5j003011m2u3ao9mhh	cm3xv6vyj00me7jww8fatnd46	PhilHealth	900	PhilHealth contribution	cm3y7yd5g002w11m27ady5dhp	2024-11-26 08:52:47.764	2024-11-26 08:52:47.764
cm3y7yd5j003211m2tbytpzvg	cm3xv6vyj00me7jww8fatnd46	PagIBIG	100	PagIBIG contribution	cm3y7yd5g002w11m27ady5dhp	2024-11-26 08:52:47.764	2024-11-26 08:52:47.764
cm3y7yd5j003411m2ydity3wn	cm3xv6vyj00me7jww8fatnd46	Tax	2408.598	Tax contribution	cm3y7yd5g002w11m27ady5dhp	2024-11-26 08:52:47.764	2024-11-26 08:52:47.764
cm3y7yd5q003911m2dzsj627l	cm3xufw6p00k97jww8n9qq7fq	SSS	1125	SSS contribution	cm3y7yd5q003711m2llgml1z2	2024-11-26 08:52:47.774	2024-11-26 08:52:47.774
cm3y7yd5q003b11m26ghqt4vh	cm3xufw6p00k97jww8n9qq7fq	PhilHealth	900	PhilHealth contribution	cm3y7yd5q003711m2llgml1z2	2024-11-26 08:52:47.774	2024-11-26 08:52:47.774
cm3y7yd5r003d11m28iosyb41	cm3xufw6p00k97jww8n9qq7fq	PagIBIG	100	PagIBIG contribution	cm3y7yd5q003711m2llgml1z2	2024-11-26 08:52:47.774	2024-11-26 08:52:47.774
cm3y7yd5r003f11m21hkzqy7f	cm3xufw6p00k97jww8n9qq7fq	Tax	2408.598	Tax contribution	cm3y7yd5q003711m2llgml1z2	2024-11-26 08:52:47.774	2024-11-26 08:52:47.774
cm3y7yd5z003k11m2k3ld1gkl	cm3sd5sob000698xytgsayvvu	SSS	720	SSS contribution	cm3y7yd5y003i11m236bps05u	2024-11-26 08:52:47.782	2024-11-26 08:52:47.782
cm3y7yd5z003m11m2phijdcj3	cm3sd5sob000698xytgsayvvu	PhilHealth	400	PhilHealth contribution	cm3y7yd5y003i11m236bps05u	2024-11-26 08:52:47.782	2024-11-26 08:52:47.782
cm3y7yd5z003o11m2j7ta17r4	cm3sd5sob000698xytgsayvvu	PagIBIG	100	PagIBIG contribution	cm3y7yd5y003i11m236bps05u	2024-11-26 08:52:47.782	2024-11-26 08:52:47.782
cm3y7yd5z003q11m2gyap3643	cm3sd5sob000698xytgsayvvu	Tax	0	Tax contribution	cm3y7yd5y003i11m236bps05u	2024-11-26 08:52:47.782	2024-11-26 08:52:47.782
cm3y7yd6b003v11m29qgyox8n	emman	SSS	765	SSS contribution	cm3y7yd67003t11m22m4lcfr7	2024-11-26 08:52:47.79	2024-11-26 08:52:47.79
cm3y7yd6b003x11m2tc9lb0mx	emman	PhilHealth	425	PhilHealth contribution	cm3y7yd67003t11m22m4lcfr7	2024-11-26 08:52:47.79	2024-11-26 08:52:47.79
cm3y7yd6b003z11m2bdwhrjuc	emman	PagIBIG	100	PagIBIG contribution	cm3y7yd67003t11m22m4lcfr7	2024-11-26 08:52:47.79	2024-11-26 08:52:47.79
cm3y7yd6b004111m2i11r4gsv	emman	Tax	0	Tax contribution	cm3y7yd67003t11m22m4lcfr7	2024-11-26 08:52:47.79	2024-11-26 08:52:47.79
cm3y7yd6k004811m2k6tyrnkm	cm3sd6n7y000h98xyfpmb6any	PhilHealth	400	PhilHealth contribution	cm3y7yd6j004411m2fi06w93m	2024-11-26 08:52:47.803	2024-11-26 08:52:47.803
cm3y7yd6k004a11m2zlc4i613	cm3sd6n7y000h98xyfpmb6any	PagIBIG	100	PagIBIG contribution	cm3y7yd6j004411m2fi06w93m	2024-11-26 08:52:47.803	2024-11-26 08:52:47.803
cm3y7yd6k004c11m2lqbrqyw4	cm3sd6n7y000h98xyfpmb6any	Tax	0	Tax contribution	cm3y7yd6j004411m2fi06w93m	2024-11-26 08:52:47.803	2024-11-26 08:52:47.803
cm3wx7w36000i7jwwcija1buc	cm3sd6n7y000h98xyfpmb6any	Disbursement	10	test	cm3y7yd6j004411m2fi06w93m	2024-11-25 11:04:30.258	2024-11-26 08:52:47.803
cm3y7yd6r004h11m2w7mjqa6p	cm3xv4w6000m37jww5tkffps0	SSS	1125	SSS contribution	cm3y7yd6q004f11m2gviu7a94	2024-11-26 08:52:47.81	2024-11-26 08:52:47.81
cm3y7yd6r004j11m232dem0w4	cm3xv4w6000m37jww5tkffps0	PhilHealth	1500	PhilHealth contribution	cm3y7yd6q004f11m2gviu7a94	2024-11-26 08:52:47.81	2024-11-26 08:52:47.81
cm3y7yd6r004l11m2qp16pw5l	cm3xv4w6000m37jww5tkffps0	PagIBIG	100	PagIBIG contribution	cm3y7yd6q004f11m2gviu7a94	2024-11-26 08:52:47.81	2024-11-26 08:52:47.81
cm3y7yd6r004n11m2r8hj5r03	cm3xv4w6000m37jww5tkffps0	Tax	7208.598	Tax contribution	cm3y7yd6q004f11m2gviu7a94	2024-11-26 08:52:47.81	2024-11-26 08:52:47.81
cm3y7yd6y004u11m2zeumc69z	cm3xu8bx700jn7jwwlfh8k68g	PhilHealth	400	PhilHealth contribution	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 08:52:47.817	2024-11-26 08:52:47.817
cm3y7yd6y004w11m2kep8rsax	cm3xu8bx700jn7jwwlfh8k68g	PagIBIG	100	PagIBIG contribution	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 08:52:47.817	2024-11-26 08:52:47.817
cm3y7yd6y004y11m2xh1h4pnt	cm3xu8bx700jn7jwwlfh8k68g	Tax	0	Tax contribution	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 08:52:47.817	2024-11-26 08:52:47.817
cm3y7yd75005311m2x6mz6yw3	cm3xuz9oj00lh7jww07cy3cil	SSS	1125	SSS contribution	cm3y7yd74005111m2j15yehv7	2024-11-26 08:52:47.824	2024-11-26 08:52:47.824
cm3y7yd75005511m2zd3f6uwt	cm3xuz9oj00lh7jww07cy3cil	PhilHealth	1025	PhilHealth contribution	cm3y7yd74005111m2j15yehv7	2024-11-26 08:52:47.824	2024-11-26 08:52:47.824
cm3y7yd75005711m2q8lpx6dg	cm3xuz9oj00lh7jww07cy3cil	PagIBIG	100	PagIBIG contribution	cm3y7yd74005111m2j15yehv7	2024-11-26 08:52:47.824	2024-11-26 08:52:47.824
cm3y7yd75005911m2k08hivx9	cm3xuz9oj00lh7jww07cy3cil	Tax	3408.598	Tax contribution	cm3y7yd74005111m2j15yehv7	2024-11-26 08:52:47.824	2024-11-26 08:52:47.824
cm3y7yd7d005e11m2j5u1bjfh	cm3xusu1p00l67jwwmm29up9j	SSS	1125	SSS contribution	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 08:52:47.832	2024-11-26 08:52:47.832
cm3y7yd7d005g11m2g743mlua	cm3xusu1p00l67jwwmm29up9j	PhilHealth	650	PhilHealth contribution	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 08:52:47.832	2024-11-26 08:52:47.832
cm3y7yd7e005i11m2iv8ow7q9	cm3xusu1p00l67jwwmm29up9j	PagIBIG	100	PagIBIG contribution	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 08:52:47.832	2024-11-26 08:52:47.832
cm3y7yd7e005k11m2ylaxqw4u	cm3xusu1p00l67jwwmm29up9j	Tax	775.0485000000002	Tax contribution	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 08:52:47.832	2024-11-26 08:52:47.832
\.


--
-- Data for Name: Department; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Department" ("id", "departmentName", "departmentDescription", "status", "departmentHeadUserId", "createdAt", "updatedAt", "createdBy") FROM stdin;
cm3rieny30003uks91p9xxgq4	IT Department	Handles IT	ACTIVE	emman	2024-11-21 16:11:01.179	2024-11-21 16:11:01.179	emman
cm3w8dcka0005ryyfeugx1fjr	Security Department	Its	ACTIVE	cm3sd6n7y000h98xyfpmb6any	2024-11-24 23:28:54.49	2024-11-24 23:35:41.487	emman
cm3xvx1lh00qf7jwwz4ykdah7	HR Department	Handles the manpower	ACTIVE	cm3xuoj8d00kv7jwwop9hwrrk	2024-11-26 03:15:50.742	2024-11-26 03:15:50.742	emman
cm3y86r8j006211m254mi3jea	Ateneo Department	ADDU	ACTIVE	cm3xv2tuq00ls7jwwsxzu6lcp	2024-11-26 08:59:19.268	2024-11-26 08:59:19.268	emman
cm3xvsnd000o57jwwf20l74ou	Engineering Department	Handles All the Engineering Teams	ACTIVE	cm3xuz9oj00lh7jww07cy3cil	2024-11-26 03:12:25.668	2024-11-26 09:03:55.507	emman
\.


--
-- Data for Name: DepartmentSalaryIncrease; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."DepartmentSalaryIncrease" ("departmentId", "salaryIncreaseEventId") FROM stdin;
cm3rieny30003uks91p9xxgq4	cm3xxv78802ql7jwwmfx37gty
cm3xvx1lh00qf7jwwz4ykdah7	cm3y0jnec02vr7jwwop8jdffm
cm3xvx1lh00qf7jwwz4ykdah7	cm3y80z8a005o11m20wlrrkl4
\.


--
-- Data for Name: Designation; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Designation" ("id", "designationName", "designationDescription", "status", "departmentId", "designationHeadUserId", "designationSalary", "createdAt", "updatedAt", "createdBy") FROM stdin;
cm3xvruoh00nz7jwwm2qx42s3	Monitoring Designation	Handles CCTVs	ACTIVE	cm3w8dcka0005ryyfeugx1fjr	cm3xv2tuq00ls7jwwsxzu6lcp	5000	2024-11-26 03:11:48.497	2024-11-26 03:11:48.497	emman
cm3xvta2r00ob7jww97mmy8gv	Electrical Engineering Designation	Handles Electronics	ACTIVE	cm3xvsnd000o57jwwf20l74ou	cm3xvamu600mp7jwwmgb1kf5e	5000	2024-11-26 03:12:55.108	2024-11-26 03:12:55.108	emman
cm3xw1yqq00rv7jwwild4i9pw	Civil Engineering Department	Civil Engineers	ACTIVE	cm3xvsnd000o57jwwf20l74ou	cm3xuoj8d00kv7jwwop9hwrrk	5000	2024-11-26 03:19:40.322	2024-11-26 03:19:40.322	emman
cm3rif3dd0007uks9t239m816	Hacking Designation	Team IT	ACTIVE	cm3rieny30003uks91p9xxgq4	emman	11000	2024-11-21 16:11:21.169	2024-11-26 04:10:23.96	emman
cm3xvscbm00o37jwwshowk8sh	Systems Designation	Handles EMS	ACTIVE	cm3rieny30003uks91p9xxgq4	cm3xu8bx700jn7jwwlfh8k68g	10000	2024-11-26 03:12:11.362	2024-11-26 04:10:23.96	emman
cm3xvxjtp00ql7jwwn23lxirz	HR Designation	Handles HR	ACTIVE	cm3xvx1lh00qf7jwwz4ykdah7	cm3sd6n7y000h98xyfpmb6any	11000	2024-11-26 03:16:14.365	2024-11-26 09:05:13.757	emman
\.


--
-- Data for Name: DesignationSalaryIncrease; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."DesignationSalaryIncrease" ("designationId", "salaryIncreaseEventId") FROM stdin;
cm3rif3dd0007uks9t239m816	cm3wmqo9x000tryyfg0rdz5a1
\.


--
-- Data for Name: Documents; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Documents" ("id", "documentName", "documentType", "documentLink", "createdAt", "updatedAt", "userId") FROM stdin;
\.


--
-- Data for Name: EmergencyContact; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."EmergencyContact" ("id", "firstName", "middleName", "lastName", "relationship", "contactNumber", "emailAddress", "userId") FROM stdin;
cm3sgw687001a98xygzmwb058	Maria	Theresa	Aguado	Son	09213456789	sad@gmail.com	emman
\.


--
-- Data for Name: GovernmentContribution; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."GovernmentContribution" ("id", "type", "brackets", "createdAt", "updatedAt") FROM stdin;
cm3rid7zh0000eghcxrvnudrc	SSS	{"table": [[1000, 3249.99, 135], [3250, 3749.99, 157.5], [3750, 4249.99, 180], [4250, 4749.99, 202.5], [4750, 5249.99, 225], [5250, 5749.99, 247.5], [5750, 6249.99, 270], [6250, 6749.99, 292.5], [6750, 7249.99, 315], [7250, 7749.99, 337.5], [7750, 8249.99, 360], [8250, 8749.99, 382.5], [8750, 9249.99, 405], [9250, 9749.99, 427.5], [9750, 10249.99, 450], [10250, 10749.99, 472.5], [10750, 11249.99, 495], [11250, 11749.99, 517.5], [11750, 12249.99, 540], [12250, 12749.99, 562.5], [12750, 13249.99, 585], [13250, 13749.99, 607.5], [13750, 14249.99, 630], [14250, 14749.99, 652.5], [14750, 15249.99, 675], [15250, 15749.99, 697.5], [15750, 16249.99, 720], [16250, 16749.99, 742.5], [16750, 17249.99, 765], [17250, 17749.99, 787.5], [17750, 18249.99, 810], [18250, 18749.99, 832.5], [18750, 19249.99, 855], [19250, 19749.99, 877.5], [19750, 20249.99, 900], [20250, 20749.99, 922.5], [20750, 21249.99, 945], [21250, 21749.99, 967.5], [21750, 22249.99, 990], [22250, 22749.99, 1012.5], [22270, 23249.99, 1035], [23250, 23749.99, 1057.5], [23750, 24249.99, 1080], [24250, 24279.99, 1102.5], [24750, 9007199254740991, 1125]]}	2024-11-21 16:09:53.837	2024-11-25 12:34:25.182
cm3rid7zs0001eghc86ycn2ab	PhilHealth	{"rules": [{"maxSalary": 10000, "contribution": 225}, {"rate": 0.025, "maxSalary": 89999.99, "minSalary": 10000.01}, {"minSalary": 90000, "contribution": 4050}]}	2024-11-21 16:09:53.849	2024-11-26 04:18:22.75
cm3rid7zu0002eghcnaa69jzu	PagIBIG	{"rules": [{"rate": 0.01, "maxSalary": 1500}, {"rate": 0.02, "maxSalary": 4999.99, "minSalary": 1500.01}, {"minSalary": 5000, "contribution": 100}]}	2024-11-21 16:09:53.851	2024-11-26 04:20:42.867
cm3rid7zw0003eghcihoh2hij	Tax	{"rules": [{"rate": 0, "deduction": 0, "minSalary": 20833}, {"rate": 0.15, "deduction": 0, "maxSalary": 33332, "minSalary": 20833.01}, {"rate": 0.2, "deduction": 1875, "maxSalary": 66666, "minSalary": 33332.01}, {"rate": 0.25, "deduction": 8541.8, "maxSalary": 166666, "minSalary": 66666.01}, {"rate": 0.3, "deduction": 33541.8, "maxSalary": 666666, "minSalary": 166666.01}, {"rate": 0.35, "deduction": 183541.8, "minSalary": 666666.01}]}	2024-11-21 16:09:53.853	2024-11-26 09:09:35.82
\.


--
-- Data for Name: GovernmentId; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."GovernmentId" ("id", "userId", "sssNumber", "tinNumber", "philHealthNumber", "pagIbigNumber", "createdAt", "updatedAt") FROM stdin;
cm3sd5sok000c98xylli1l27s	cm3sd5sob000698xytgsayvvu	123	123	12	3123	2024-11-22 06:31:55.498	2024-11-22 06:31:55.498
cm3sd6n83000n98xynki5xjiu	cm3sd6n7y000h98xyfpmb6any	231	123	123	123	2024-11-22 06:32:35.086	2024-11-22 06:32:35.086
cm3xpueyn00003kkl8g9c4dhg	emman	1	12	12	12	2024-11-26 00:25:50.399	2024-11-26 00:25:38.242
cm3xu8bxg00jt7jww9wr4dv4m	cm3xu8bx700jn7jwwlfh8k68g	12313	12311	12331	12313	2024-11-26 02:28:38.105	2024-11-26 02:28:38.105
cm3xud7bq00k47jwwf94b6v21	cm3xud7bl00jy7jww9qzfi51c	23421321312	432432432432432	2348742332	90321043843	2024-11-26 02:32:25.425	2024-11-26 02:32:25.425
cm3xufw6v00kf7jww0050i6er	cm3xufw6p00k97jww8n9qq7fq	434324238492	56748392242	74839212384	7548392102938475	2024-11-26 02:34:30.961	2024-11-26 02:34:30.961
cm3xuj38k00kq7jwwv7jcl5mc	cm3xuj38h00kk7jwwnwywtik2	789876543	7656787434567890	34567898765432	987678654345432	2024-11-26 02:37:00.064	2024-11-26 02:37:00.064
cm3xuoj8g00l17jwwdyj7d4vj	cm3xuoj8d00kv7jwwop9hwrrk	32123456543	65432123456789	3454323458765	876543456789876	2024-11-26 02:41:14.077	2024-11-26 02:41:14.077
cm3xusu1s00lc7jwwl0xe5t5v	cm3xusu1p00l67jwwmm29up9j	13454325431	876544567897	1234567909876	98734567890098	2024-11-26 02:44:34.717	2024-11-26 02:44:34.717
cm3xuz9oq00ln7jwwrb8bqlvq	cm3xuz9oj00lh7jww07cy3cil	345676543567	76545678765	87654567876	98765456789	2024-11-26 02:49:34.914	2024-11-26 02:49:34.914
cm3xv2tuw00ly7jwww8noaqm8	cm3xv2tuq00ls7jwwsxzu6lcp	6547382412	564738293847	123459876	6574839238	2024-11-26 02:52:21.026	2024-11-26 02:52:21.026
cm3xv4w6300m97jwwtoknukzu	cm3xv4w6000m37jww5tkffps0	678909876543	1234567898765	765432345678765	876545678998	2024-11-26 02:53:57.336	2024-11-26 02:53:57.336
cm3xv6vyl00mk7jwwft8w3ziv	cm3xv6vyj00me7jww8fatnd46	5647382374651	1243545433986	9876541234567890	6545678987654	2024-11-26 02:55:30.378	2024-11-26 02:55:30.378
cm3xvamub00mv7jwwfosakv0h	cm3xvamu600mp7jwwmgb1kf5e	758439238454	75843923847	12345432123456	854932384542	2024-11-26 02:58:25.182	2024-11-26 02:58:25.182
cm3xvd52y00n67jwwe07t0pya	cm3xvd52v00n07jwwu9txe547	675463524567189	56473827635	58746532678876	87564532678	2024-11-26 03:00:22.135	2024-11-26 03:00:22.135
cm3xvft2n00nh7jww7uy6i3wm	cm3xvft2k00nb7jwwzijna876	5849328713	948763526	43122678439	4392876364	2024-11-26 03:02:26.54	2024-11-26 03:02:26.54
cm3xvi9qu00ns7jwwb9b9l3dr	cm3xvi9qr00nm7jwwmi7v4fru	5437283764432	543234567654	2132456765	43567564533232	2024-11-26 03:04:21.458	2024-11-26 03:04:21.458
cm3y7pz28000j11m2xyja1mma	cm3y7pz20000d11m2522rpsoa	1234567890	12345678912	123456789012	123456789123	2024-11-26 08:46:16.247	2024-11-26 08:46:16.247
\.


--
-- Data for Name: Holiday; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Holiday" ("id", "date", "name", "createdAt", "updatedAt") FROM stdin;
clropux4k00op98xycnbbl8yn	2023-12-31 16:00:00	New Year's Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4m00oq98xyiflaif0l	2024-02-24 16:00:00	EDSA People Power Revolution Anniversary	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4o00or98xy7hmkgliy	2024-04-08 16:00:00	Araw ng Kagitingan	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4r00os98xyhuq3s43i	2024-04-30 16:00:00	Labor Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4s00ot98xyagfjwgyz	2024-06-11 16:00:00	Independence Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4s00ou98xy6pk2r320	2024-08-20 16:00:00	Ninoy Aquino Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4t00ov98xyfnm0w34a	2024-08-30 16:00:00	National Heroes Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4w00ow98xyllneluhp	2024-10-31 16:00:00	All Saints' Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4x00ox98xy9ydy2yox	2024-11-01 16:00:00	All Souls' Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4y00oy98xytdt3kdh4	2024-11-29 16:00:00	Bonifacio Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4z00oz98xy7bv552v4	2024-12-24 16:00:00	Christmas Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux5000p098xyu1kkcpv7	2024-12-29 16:00:00	Rizal Day	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux5200p198xyi46ymkgi	2024-12-30 16:00:00	New Year's Eve	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
cm3wvh78e00047jwwac82q6zd	2024-12-22 16:00:00	Jousheen Salac Birthday	2024-11-25 10:15:45.374	2024-11-25 10:15:45.374
\.


--
-- Data for Name: Leaves; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Leaves" ("id", "userId", "startDate", "endDate", "leaveStatus", "reason", "leaveType", "documentLink", "createdAt", "updatedAt") FROM stdin;
cm3sva95j00tw98xy7oq2bjp5	emman	2024-12-02 00:00:00	2024-12-12 00:00:00	REJECTED	wow	SICK	https://yff2xv1mgpf5hkyr.public?.blob.vercel-storage.com/leaveRequests/emman-badzys-Sz1F3luGkyJ6hc5FnwXLBH8pVWhYWz.jpg	2024-11-22 14:59:16.567	2024-11-23 04:10:43.007
cm3xxon2802mm7jwwoo7xsyqg	emman	2024-11-27 00:00:00	2024-11-29 00:00:00	PENDING	Fever	VACATION	https://yff2xv1mgpf5hkyr.public?.blob.vercel-storage.com/leaveRequests/emman-Payslip_Tranquilan_2024-11-25-quCQTaabXp4Pi9D4HgVG6YoMtX784U.pdf	2024-11-26 04:05:17.888	2024-11-26 04:05:17.888
cm3y7ufk6000s11m2a0b2v7sj	emman	2024-11-28 00:00:00	2024-11-30 00:00:00	PENDING	Fever	SICK	https://yff2xv1mgpf5hkyr.public?.blob.vercel-storage.com/leaveRequests/emman-Payslip_Floresta_2024-11-25-cUV5ALJzC7IspnEsV2cP2kow26Yz8p.pdf	2024-11-26 08:49:44.262	2024-11-26 08:49:44.262
\.


--
-- Data for Name: Overtimes; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Overtimes" ("id", "reason", "status", "overtimeType", "userId", "timeOut", "clockIn", "clockOut", "createdAt", "updatedAt") FROM stdin;
cm3srm8vn00to98xyknrzcciu	test	PENDING	REGULAR	emman	2024-11-22 10:01:00	2024-11-22 13:16:37.619	2024-11-22 13:19:21.414	2024-11-22 13:16:37.62	2024-11-22 13:19:21.415
\.


--
-- Data for Name: PasswordResetToken; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."PasswordResetToken" ("id", "email", "token", "expires") FROM stdin;
\.


--
-- Data for Name: Payroll; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Payroll" ("id", "payPeriodStart", "payPeriodEnd", "payrollStatus", "totalAmount", "createdAt", "updatedAt") FROM stdin;
cm3xw6h4500rw7jwwj0310gmh	2024-09-25 16:00:00	2024-10-10 15:59:59.999	APPROVED	465767.87200000003	2024-11-26 03:23:10.757	2024-11-26 07:19:15.425
cm3xw72ka00rz7jwwuy9h7n0g	2024-10-10 16:00:00	2024-10-25 15:59:59.999	APPROVED	474767.87200000003	2024-11-26 03:23:38.555	2024-11-26 07:19:26.481
cm3xw7hv700s27jwwb6p6npht	2024-10-25 16:00:00	2024-11-10 15:59:59.999	APPROVED	474767.87200000003	2024-11-26 03:23:58.387	2024-11-26 07:19:34.509
cm3y7yd35000z11m2r8n014zu	2024-11-10 16:00:00	2024-11-25 15:59:59.999	PENDING	410383.3750454546	2024-11-26 08:52:47.681	2024-11-26 08:52:47.838
cm3y8q57t006c11m26hrsvbk3	2024-12-30 16:00:00	2024-12-31 15:59:59.999	PENDING	0	2024-11-26 09:14:23.849	2024-11-26 09:14:23.849
\.


--
-- Data for Name: PayrollItem; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."PayrollItem" ("id", "payrollId", "userId", "basicSalary", "overtimeSalary", "dailyRate", "additionalEarnings", "lateDeductions", "earlyClockOutDeductions", "totalDeductions", "netSalary", "daysWorked", "daysNotWorked", "daysLeave", "minutesWorked", "minutesNotWorked", "minutesEarlyOut", "minutesLate", "minutesOvertime", "specialDayMinutes", "specialDayEarnings", "createdAt", "updatedAt") FROM stdin;
cm3xwa9jl02637jwwknfdmyoi	cm3xw7hv700s27jwwb6p6npht	cm3xu8bx700jn7jwwlfh8k68g	11000	0	1222.222222222222	0	0	0	870	10130	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.569	2024-11-26 03:26:07.569
cm3xwa9k9026e7jww0sk7vhn3	cm3xw7hv700s27jwwb6p6npht	cm3xuj38h00kk7jwwnwywtik2	55000	0	6111.111111111111	0	0	0	8808.598	46191.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.593	2024-11-26 03:26:07.593
cm3xwa9kq026p7jwwkcs9mpla	cm3xw7hv700s27jwwb6p6npht	cm3xud7bl00jy7jww9qzfi51c	26000	0	2888.888888888889	0	0	0	2650.0485	23349.9515	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.61	2024-11-26 03:26:07.61
cm3xwa9l602707jwwlcjj1u0n	cm3xw7hv700s27jwwb6p6npht	cm3xuoj8d00kv7jwwop9hwrrk	35000	0	3888.888888888889	0	0	0	4308.598	30691.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.626	2024-11-26 03:26:07.626
cm3xwa9ll027b7jwwys6rkhnn	cm3xw7hv700s27jwwb6p6npht	cm3xufw6p00k97jww8n9qq7fq	31000	0	3444.444444444444	0	0	0	3525.0485	27474.9515	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.641	2024-11-26 03:26:07.641
cm3xwa9m0027m7jwwehfe9j6r	cm3xw7hv700s27jwwb6p6npht	cm3xusu1p00l67jwwmm29up9j	25000	0	2777.777777777778	0	0	0	2475.0485	22524.9515	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.656	2024-11-26 03:26:07.656
cm3xwa9mg027x7jwwsaqbcwhu	cm3xw7hv700s27jwwb6p6npht	cm3xuz9oj00lh7jww07cy3cil	40000	0	4444.444444444444	0	0	0	5433.598	34566.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.672	2024-11-26 03:26:07.672
cm3xwa9mw02887jwwcsqhtuz1	cm3xw7hv700s27jwwb6p6npht	cm3xv4w6000m37jww5tkffps0	55000	0	6111.111111111111	0	0	0	8808.598	46191.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.688	2024-11-26 03:26:07.688
cm3xwa9nc028j7jwwbd86me2q	cm3xw7hv700s27jwwb6p6npht	cm3xvd52v00n07jwwu9txe547	35000	0	3888.888888888889	0	0	0	4308.598	30691.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.704	2024-11-26 03:26:07.704
cm3xwa9nr028u7jwwxa6l9m9k	cm3xw7hv700s27jwwb6p6npht	cm3xv2tuq00ls7jwwsxzu6lcp	31000	0	3444.444444444444	0	0	0	3525.0485	27474.9515	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.719	2024-11-26 03:26:07.719
cm3xwa9o602957jwwcoyadat1	cm3xw7hv700s27jwwb6p6npht	cm3xv6vyj00me7jww8fatnd46	30000	0	3333.333333333333	0	0	0	3350.0485	26649.9515	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.734	2024-11-26 03:26:07.734
cm3xwa9oj029g7jwwqe3rfx8t	cm3xw7hv700s27jwwb6p6npht	cm3xvamu600mp7jwwmgb1kf5e	86000	0	9555.555555555555	0	0	0	16750.2975	69249.7025	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.747	2024-11-26 03:26:07.747
cm3xwa9ow029r7jww575jxxcf	cm3xw7hv700s27jwwb6p6npht	cm3xvi9qr00nm7jwwmi7v4fru	35000	0	3888.888888888889	0	0	0	4308.598	30691.402	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.76	2024-11-26 03:26:07.76
cm3xwa9pb02a27jwwztuh38v6	cm3xw7hv700s27jwwb6p6npht	cm3xvft2k00nb7jwwzijna876	20000	0	2222.222222222222	0	0	0	1500	18500	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.775	2024-11-26 03:26:07.775
cm3xwa9q002ad7jwwjrmcujv1	cm3xw7hv700s27jwwb6p6npht	cm3sd6n7y000h98xyfpmb6any	11000	0	1222.222222222222	0	0	0	870	10130	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.8	2024-11-26 03:26:07.8
cm3xwa9qj02ao7jwwjyy17l4h	cm3xw7hv700s27jwwb6p6npht	cm3sd5sob000698xytgsayvvu	11000	0	1222.222222222222	0	0	0	870	10130	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.819	2024-11-26 03:26:07.819
cm3xwa9r302az7jwwvm765rjf	cm3xw7hv700s27jwwb6p6npht	emman	11000	0	1222.222222222222	0	0	0	870	10130	9	0	0	5400	0	0	0	0	0	0	2024-11-26 03:26:07.839	2024-11-26 03:26:07.839
cm3xwaq2i02bc7jwwmkuczqiz	cm3xw72ka00rz7jwwuy9h7n0g	cm3xu8bx700jn7jwwlfh8k68g	11000	0	1000	0	0	0	870	10130	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:28.986	2024-11-26 03:26:28.986
cm3xwaq3102bn7jww28zg5z8b	cm3xw72ka00rz7jwwuy9h7n0g	cm3xuj38h00kk7jwwnwywtik2	55000	0	5000	0	0	0	8808.598	46191.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.005	2024-11-26 03:26:29.005
cm3xwaq3g02by7jwwlztlj0j0	cm3xw72ka00rz7jwwuy9h7n0g	cm3xud7bl00jy7jww9qzfi51c	26000	0	2363.636363636364	0	0	0	2650.0485	23349.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.02	2024-11-26 03:26:29.02
cm3xwaq3u02c97jww0pj05nhy	cm3xw72ka00rz7jwwuy9h7n0g	cm3xuoj8d00kv7jwwop9hwrrk	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.034	2024-11-26 03:26:29.034
cm3xwaq4902ck7jwwohz45zls	cm3xw72ka00rz7jwwuy9h7n0g	cm3xufw6p00k97jww8n9qq7fq	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.047	2024-11-26 03:26:29.047
cm3xwaq4m02cv7jww6vruxive	cm3xw72ka00rz7jwwuy9h7n0g	cm3xusu1p00l67jwwmm29up9j	25000	0	2272.727272727273	0	0	0	2475.0485	22524.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.062	2024-11-26 03:26:29.062
cm3xwaq5102d67jwweh96wcqx	cm3xw72ka00rz7jwwuy9h7n0g	cm3xuz9oj00lh7jww07cy3cil	40000	0	3636.363636363636	0	0	0	5433.598	34566.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.077	2024-11-26 03:26:29.077
cm3xwaq5g02dh7jww74ftsvb0	cm3xw72ka00rz7jwwuy9h7n0g	cm3xv4w6000m37jww5tkffps0	55000	0	5000	0	0	0	8808.598	46191.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.092	2024-11-26 03:26:29.092
cm3xwaq5w02ds7jww8w8x9pob	cm3xw72ka00rz7jwwuy9h7n0g	cm3xvd52v00n07jwwu9txe547	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.108	2024-11-26 03:26:29.108
cm3xwaq7o02e37jwwsv1wlecm	cm3xw72ka00rz7jwwuy9h7n0g	cm3xv2tuq00ls7jwwsxzu6lcp	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.171	2024-11-26 03:26:29.171
cm3xwaq8i02ee7jww6n3757v8	cm3xw72ka00rz7jwwuy9h7n0g	cm3xv6vyj00me7jww8fatnd46	30000	0	2727.272727272727	0	0	0	3350.0485	26649.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.201	2024-11-26 03:26:29.201
cm3xwaq9b02ep7jwwvjfajti7	cm3xw72ka00rz7jwwuy9h7n0g	cm3xvamu600mp7jwwmgb1kf5e	86000	0	7818.181818181818	0	0	0	16750.2975	69249.7025	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.23	2024-11-26 03:26:29.23
cm3xwaq9p02f07jwwfbt77mwi	cm3xw72ka00rz7jwwuy9h7n0g	cm3xvi9qr00nm7jwwmi7v4fru	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.245	2024-11-26 03:26:29.245
cm3xwaqa302fb7jwwp4noh3gi	cm3xw72ka00rz7jwwuy9h7n0g	cm3xvft2k00nb7jwwzijna876	20000	0	1818.181818181818	0	0	0	1500	18500	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.259	2024-11-26 03:26:29.259
cm3xwaqav02fm7jwwl3fdip74	cm3xw72ka00rz7jwwuy9h7n0g	cm3sd6n7y000h98xyfpmb6any	11000	0	1000	0	0	0	870	10130	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.287	2024-11-26 03:26:29.287
cm3xwaqbc02fx7jwwpm1qptq6	cm3xw72ka00rz7jwwuy9h7n0g	cm3sd5sob000698xytgsayvvu	11000	0	1000	0	0	0	870	10130	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.304	2024-11-26 03:26:29.304
cm3xwaqbs02g87jwwkunjnumr	cm3xw72ka00rz7jwwuy9h7n0g	emman	11000	0	1000	0	0	0	870	10130	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:29.32	2024-11-26 03:26:29.32
cm3xwaylh02gl7jwwazny1fhb	cm3xw6h4500rw7jwwj0310gmh	cm3xu8bx700jn7jwwlfh8k68g	11000	0	1000	0	0	0	870	10130	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.037	2024-11-26 03:26:40.037
cm3xwaym502gw7jww7v5zypqk	cm3xw6h4500rw7jwwj0310gmh	cm3xuj38h00kk7jwwnwywtik2	55000	0	5000	0	0	0	8808.598	46191.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.061	2024-11-26 03:26:40.061
cm3xwaymj02h77jwwqniwklfq	cm3xw6h4500rw7jwwj0310gmh	cm3xud7bl00jy7jww9qzfi51c	26000	0	2363.636363636364	0	0	0	2650.0485	23349.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.075	2024-11-26 03:26:40.075
cm3xwaymx02hi7jwwr7yo62cl	cm3xw6h4500rw7jwwj0310gmh	cm3xuoj8d00kv7jwwop9hwrrk	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.089	2024-11-26 03:26:40.089
cm3xwaync02ht7jwws7vif268	cm3xw6h4500rw7jwwj0310gmh	cm3xufw6p00k97jww8n9qq7fq	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.103	2024-11-26 03:26:40.103
cm3xwaynq02i47jwwullojyxh	cm3xw6h4500rw7jwwj0310gmh	cm3xusu1p00l67jwwmm29up9j	25000	0	2272.727272727273	0	0	0	2475.0485	22524.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.118	2024-11-26 03:26:40.118
cm3xwayo502if7jwwzozvnc2x	cm3xw6h4500rw7jwwj0310gmh	cm3xuz9oj00lh7jww07cy3cil	40000	0	3636.363636363636	0	0	0	5433.598	34566.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.133	2024-11-26 03:26:40.133
cm3xwayoj02iq7jwwj4cy3u1m	cm3xw6h4500rw7jwwj0310gmh	cm3xv4w6000m37jww5tkffps0	55000	0	5000	0	0	0	8808.598	46191.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.147	2024-11-26 03:26:40.147
cm3xwayoy02j17jwwwxnm3ybd	cm3xw6h4500rw7jwwj0310gmh	cm3xvd52v00n07jwwu9txe547	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.162	2024-11-26 03:26:40.162
cm3xwaype02jc7jww7028frj5	cm3xw6h4500rw7jwwj0310gmh	cm3xv2tuq00ls7jwwsxzu6lcp	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.178	2024-11-26 03:26:40.178
cm3xwayps02jn7jwwcwq1aqkh	cm3xw6h4500rw7jwwj0310gmh	cm3xv6vyj00me7jww8fatnd46	30000	0	2727.272727272727	0	0	0	3350.0485	26649.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.192	2024-11-26 03:26:40.192
cm3xwayqa02jy7jww4nd86l91	cm3xw6h4500rw7jwwj0310gmh	cm3xvamu600mp7jwwmgb1kf5e	86000	0	7818.181818181818	0	0	0	16750.2975	69249.7025	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.21	2024-11-26 03:26:40.21
cm3xwayqq02k97jwwyn8ae2eg	cm3xw6h4500rw7jwwj0310gmh	cm3xvi9qr00nm7jwwmi7v4fru	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.225	2024-11-26 03:26:40.225
cm3xwayr402kk7jwwbq6q8l7i	cm3xw6h4500rw7jwwj0310gmh	cm3xvft2k00nb7jwwzijna876	20000	0	1818.181818181818	0	0	0	1500	18500	11	0	0	6600	0	0	0	0	0	0	2024-11-26 03:26:40.24	2024-11-26 03:26:40.24
cm3xwayrk02kv7jwwfrgzrudz	cm3xw6h4500rw7jwwj0310gmh	cm3sd6n7y000h98xyfpmb6any	11000	0	1000	0	0	0	3870	7130	8	3	0	4800	1800	0	0	0	0	0	2024-11-26 03:26:40.256	2024-11-26 03:26:40.256
cm3xways102l97jwwcr64dd2o	cm3xw6h4500rw7jwwj0310gmh	cm3sd5sob000698xytgsayvvu	11000	0	1000	0	0	0	3870	7130	8	3	0	4800	1800	0	0	0	0	0	2024-11-26 03:26:40.272	2024-11-26 03:26:40.272
cm3xwaysh02ln7jwwbif5piag	cm3xw6h4500rw7jwwj0310gmh	emman	11000	0	1000	0	0	0	3870	7130	8	3	0	4800	1800	0	0	0	0	0	2024-11-26 03:26:40.289	2024-11-26 03:26:40.289
cm3y7yd3y001211m2thni63rn	cm3y7yd35000z11m2r8n014zu	cm3y7pz20000d11m2522rpsoa	25000	0	2272.727272727273	0	0	0	27475.0485	-2475.048500000001	0	11	0	0	6600	0	0	0	0	0	2024-11-26 08:52:47.71	2024-11-26 08:52:47.71
cm3y7yd4a001d11m2vuv9oo3i	cm3y7yd35000z11m2r8n014zu	cm3xv2tuq00ls7jwwsxzu6lcp	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.722	2024-11-26 08:52:47.722
cm3y7yd4j001o11m2bg6yb9wl	cm3y7yd35000z11m2r8n014zu	cm3xvd52v00n07jwwu9txe547	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.731	2024-11-26 08:52:47.731
cm3y7yd4r001z11m2x8o8se3g	cm3y7yd35000z11m2r8n014zu	cm3xvamu600mp7jwwmgb1kf5e	86000	0	7818.181818181818	0	0	0	16750.2975	69249.7025	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.739	2024-11-26 08:52:47.739
cm3y7yd4z002a11m20u8h9422	cm3y7yd35000z11m2r8n014zu	cm3xuoj8d00kv7jwwop9hwrrk	35000	0	3181.818181818182	0	0	0	4308.598	30691.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.747	2024-11-26 08:52:47.747
cm3y7yd59002l11m2caqkukyt	cm3y7yd35000z11m2r8n014zu	cm3xud7bl00jy7jww9qzfi51c	31000	0	2818.181818181818	0	0	0	3525.0485	27474.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.757	2024-11-26 08:52:47.757
cm3y7yd5g002w11m27ady5dhp	cm3y7yd35000z11m2r8n014zu	cm3xv6vyj00me7jww8fatnd46	36000	0	3272.727272727273	0	0	0	4533.598	31466.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.764	2024-11-26 08:52:47.764
cm3y7yd5q003711m2llgml1z2	cm3y7yd35000z11m2r8n014zu	cm3xufw6p00k97jww8n9qq7fq	36000	0	3272.727272727273	0	0	0	4533.598	31466.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.774	2024-11-26 08:52:47.774
cm3y7yd5y003i11m236bps05u	cm3y7yd35000z11m2r8n014zu	cm3sd5sob000698xytgsayvvu	16000	0	1454.545454545455	0	0	0	2674.545454545455	13325.45454545455	10	1	0	6000	600	0	0	0	0	0	2024-11-26 08:52:47.782	2024-11-26 08:52:47.782
cm3y7yd67003t11m22m4lcfr7	cm3y7yd35000z11m2r8n014zu	emman	17000	0	1545.454545454545	0	0	0	2835.454545454545	14164.54545454545	10	1	0	6000	600	0	0	0	0	0	2024-11-26 08:52:47.79	2024-11-26 08:52:47.79
cm3y7yd6j004411m2fi06w93m	cm3y7yd35000z11m2r8n014zu	cm3sd6n7y000h98xyfpmb6any	16000	0	1454.545454545455	0	0	0	2684.545454545455	13315.45454545455	10	1	0	6000	600	0	0	0	0	0	2024-11-26 08:52:47.803	2024-11-26 08:52:47.803
cm3y7yd6q004f11m2gviu7a94	cm3y7yd35000z11m2r8n014zu	cm3xv4w6000m37jww5tkffps0	60000	0	5454.545454545455	0	0	0	9933.598	50066.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.81	2024-11-26 08:52:47.81
cm3y7yd6x004q11m2uxc3nqdw	cm3y7yd35000z11m2r8n014zu	cm3xu8bx700jn7jwwlfh8k68g	16000	0	1454.545454545455	0	0	0	1220	14780	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.817	2024-11-26 08:52:47.817
cm3y7yd74005111m2j15yehv7	cm3y7yd35000z11m2r8n014zu	cm3xuz9oj00lh7jww07cy3cil	41000	0	3727.272727272727	0	0	0	5658.598	35341.402	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.824	2024-11-26 08:52:47.824
cm3y7yd7c005c11m2sf9p2sq8	cm3y7yd35000z11m2r8n014zu	cm3xusu1p00l67jwwmm29up9j	26000	0	2363.636363636364	0	0	0	2650.0485	23349.9515	11	0	0	6600	0	0	0	0	0	0	2024-11-26 08:52:47.832	2024-11-26 08:52:47.832
\.


--
-- Data for Name: SalaryHistory; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."SalaryHistory" ("id", "userId", "basicSalary", "grossSalary", "startDate", "endDate", "amountIncreased", "salaryIncreaseEventId", "createdAt", "updatedAt") FROM stdin;
cm3rif3dv000buks95n0zsm23	emman	5000	5000	2024-11-21 16:10:31.595	2024-11-21 16:11:21.188	\N	\N	2024-11-21 16:11:21.188	2024-11-21 16:11:21.188
cm3wbut580009ryyfip0c1ox3	emman	5000	10000	2024-11-21 16:11:21.19	2024-11-25 01:06:27.98	0	\N	2024-11-25 01:06:27.98	2024-11-25 01:06:27.98
cm3wbv571000dryyfhxto8i6p	cm3sd5sob000698xytgsayvvu	5000	10000	2024-11-22 06:31:55.498	2024-11-25 01:06:43.597	0	\N	2024-11-25 01:06:43.597	2024-11-25 01:06:43.597
cm3wbvc4s000hryyfpeezojq7	emman	5000	5000	2024-11-25 01:06:28.023	2024-11-25 01:06:52.588	\N	\N	2024-11-25 01:06:52.588	2024-11-25 01:06:52.588
cm3wmqoaj000vryyfm6bjpgmj	cm3sd6n7y000h98xyfpmb6any	5000	10000	2024-11-22 06:32:35.086	2024-11-25 06:11:10.811	1000	cm3wmqo9x000tryyfg0rdz5a1	2024-11-25 06:11:10.811	2024-11-25 06:11:10.811
cm3wmqoao000xryyfw7goftno	emman	5000	10000	2024-11-25 01:06:52.59	2024-11-25 06:11:10.811	1000	cm3wmqo9x000tryyfg0rdz5a1	2024-11-25 06:11:10.811	2024-11-25 06:11:10.811
cm3xpo5et00fn7jwwku5xcovl	cm3sd5sob000698xytgsayvvu	5000	5000	2024-11-25 01:06:43.606	2024-11-26 00:20:58.086	\N	\N	2024-11-26 00:20:58.086	2024-11-26 00:20:58.086
cm3xvtpi400od7jwwu7w6ojkt	cm3xv4w6000m37jww5tkffps0	50000	56000	2024-11-26 02:53:57.336	2024-11-26 03:13:15.101	0	\N	2024-11-26 03:13:15.101	2024-11-26 03:13:15.101
cm3xvts6d00oh7jww3io4zwck	cm3xusu1p00l67jwwmm29up9j	20000	26000	2024-11-26 02:44:34.717	2024-11-26 03:13:18.565	0	\N	2024-11-26 03:13:18.565	2024-11-26 03:13:18.565
cm3xvtuiw00ol7jwwna9fgk8j	cm3xuj38h00kk7jwwnwywtik2	50000	56000	2024-11-26 02:37:00.064	2024-11-26 03:13:21.609	0	\N	2024-11-26 03:13:21.609	2024-11-26 03:13:21.609
cm3xvtxjy00op7jwwd3c7631u	cm3xvft2k00nb7jwwzijna876	15000	21000	2024-11-26 03:02:26.54	2024-11-26 03:13:25.534	0	\N	2024-11-26 03:13:25.534	2024-11-26 03:13:25.534
cm3xvu03u00ot7jww0z15ffhy	cm3xvi9qr00nm7jwwmi7v4fru	30000	36000	2024-11-26 03:04:21.458	2024-11-26 03:13:28.842	0	\N	2024-11-26 03:13:28.842	2024-11-26 03:13:28.842
cm3xvu36z00ox7jww2dapkba7	cm3xvd52v00n07jwwu9txe547	30000	36000	2024-11-26 03:00:22.135	2024-11-26 03:13:32.843	0	\N	2024-11-26 03:13:32.843	2024-11-26 03:13:32.843
cm3xvu5iw00p17jwwdb50huhd	cm3xv6vyj00me7jww8fatnd46	25000	31000	2024-11-26 02:55:30.378	2024-11-26 03:13:35.864	0	\N	2024-11-26 03:13:35.864	2024-11-26 03:13:35.864
cm3xvu7pu00p57jwwd076uag2	cm3xuz9oj00lh7jww07cy3cil	35000	41000	2024-11-26 02:49:34.914	2024-11-26 03:13:38.706	0	\N	2024-11-26 03:13:38.706	2024-11-26 03:13:38.706
cm3xvuact00p97jwwbutbr5do	cm3xuoj8d00kv7jwwop9hwrrk	30000	36000	2024-11-26 02:41:14.077	2024-11-26 03:13:42.125	0	\N	2024-11-26 03:13:42.125	2024-11-26 03:13:42.125
cm3xvulqy00pd7jwwqvypm7d4	cm3xusu1p00l67jwwmm29up9j	20000	20000	2024-11-26 03:13:18.567	2024-11-26 03:13:56.89	\N	\N	2024-11-26 03:13:56.89	2024-11-26 03:13:56.89
cm3xvuoxn00pj7jwwkobovdgo	cm3xv4w6000m37jww5tkffps0	50000	50000	2024-11-26 03:13:15.106	2024-11-26 03:14:01.019	\N	\N	2024-11-26 03:14:01.019	2024-11-26 03:14:01.019
cm3xvv19u00pp7jww95wvaq01	cm3xuoj8d00kv7jwwop9hwrrk	30000	30000	2024-11-26 03:13:42.126	2024-11-26 03:14:17.011	\N	\N	2024-11-26 03:14:17.011	2024-11-26 03:14:17.011
cm3xvv94400pv7jww4s9wz6hg	cm3xvd52v00n07jwwu9txe547	30000	30000	2024-11-26 03:13:32.845	2024-11-26 03:14:27.173	\N	\N	2024-11-26 03:14:27.173	2024-11-26 03:14:27.173
cm3xvwgw500q97jwwciiz0wiu	cm3xv6vyj00me7jww8fatnd46	25000	25000	2024-11-26 03:13:35.866	2024-11-26 03:15:23.91	\N	\N	2024-11-26 03:15:23.91	2024-11-26 03:15:23.91
cm3xvxz6z00qn7jwweifmh9xm	cm3xuz9oj00lh7jww07cy3cil	35000	35000	2024-11-26 03:13:38.707	2024-11-26 03:16:34.284	\N	\N	2024-11-26 03:16:34.284	2024-11-26 03:16:34.284
cm3xvz8kk00qz7jwwv82hh51k	cm3xvi9qr00nm7jwwmi7v4fru	30000	30000	2024-11-26 03:13:28.844	2024-11-26 03:17:33.092	\N	\N	2024-11-26 03:17:33.092	2024-11-26 03:17:33.092
cm3xvzemy00rb7jww3h9inei2	cm3xvft2k00nb7jwwzijna876	15000	15000	2024-11-26 03:13:25.536	2024-11-26 03:17:40.954	\N	\N	2024-11-26 03:17:40.954	2024-11-26 03:17:40.954
cm3xw09on00rn7jww8ut2pvon	cm3xuj38h00kk7jwwnwywtik2	50000	50000	2024-11-26 03:13:21.61	2024-11-26 03:18:21.191	\N	\N	2024-11-26 03:18:21.191	2024-11-26 03:18:21.191
cm3xxv78m02qn7jwwvtlx5l0j	cm3sd6n7y000h98xyfpmb6any	5000	11000	2024-11-25 06:11:10.811	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxv78p02qp7jww92gpf4db	emman	5000	11000	2024-11-25 06:11:10.811	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxv78q02qr7jww6001okuh	cm3sd5sob000698xytgsayvvu	5000	11000	2024-11-26 00:20:58.089	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxv78s02qt7jww55qaqe6b	cm3xufw6p00k97jww8n9qq7fq	25000	31000	2024-11-26 02:34:30.961	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxv78u02qv7jww3qecilhk	cm3xu8bx700jn7jwwlfh8k68g	5000	11000	2024-11-26 02:28:38.105	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxv78w02qx7jwwyo1jbvu3	cm3xv4w6000m37jww5tkffps0	50000	55000	2024-11-26 03:14:01.02	2024-11-26 04:10:23.96	5000	cm3xxv78802ql7jwwmfx37gty	2024-11-26 04:10:23.96	2024-11-26 04:10:23.96
cm3xxynqt02r17jwwl0b1gknf	cm3xv6vyj00me7jww8fatnd46	25000	30000	2024-11-26 03:15:23.912	2024-11-26 04:13:05.333	\N	\N	2024-11-26 04:13:05.333	2024-11-26 04:13:05.333
cm3y0jnep02vt7jwwnz0w7f3k	cm3xusu1p00l67jwwmm29up9j	20000	25000	2024-11-26 03:13:56.893	2024-11-26 05:25:23.892	1000	cm3y0jnec02vr7jwwop8jdffm	2024-11-26 05:25:23.892	2024-11-26 05:25:23.892
cm3y0jner02vv7jwwgwpexfjv	cm3xuz9oj00lh7jww07cy3cil	35000	40000	2024-11-26 03:16:34.288	2024-11-26 05:25:23.892	1000	cm3y0jnec02vr7jwwop8jdffm	2024-11-26 05:25:23.892	2024-11-26 05:25:23.892
cm3y0p32802vz7jww4hqb1bpm	cm3xud7bl00jy7jww9qzfi51c	20000	26000	2024-11-26 02:32:25.425	2024-11-26 05:29:37.472	\N	\N	2024-11-26 05:29:37.472	2024-11-26 05:29:37.472
cm3y5noz5000d12cw92n0agwi	emman	5000	16000	2024-11-26 04:10:23.96	2024-11-26 07:48:30.628	-4000	cm3y5noyz000b12cwkp7xd22s	2024-11-26 07:48:30.628	2024-11-26 07:48:30.628
cm3y5ohaz000j12cw3fkiq6dq	emman	1000	12000	2024-11-26 07:48:30.628	2024-11-26 07:49:07.347	4000	cm3y5ohay000h12cwmvalvcfa	2024-11-26 07:49:07.347	2024-11-26 07:49:07.347
cm3y63mko000511m2wx8olba9	emman	5000	16000	2024-11-26 07:49:07.347	2024-11-26 08:00:54.011	1000	cm3y63mki000311m2kxik3i9q	2024-11-26 08:00:54.011	2024-11-26 08:00:54.011
cm3y80z8r005q11m2y53hq0ht	cm3xusu1p00l67jwwmm29up9j	20000	26000	2024-11-26 05:25:23.892	2024-11-26 08:54:49.689	5000	cm3y80z8a005o11m20wlrrkl4	2024-11-26 08:54:49.689	2024-11-26 08:54:49.689
cm3y80z8u005s11m2puf8t83y	cm3xuz9oj00lh7jww07cy3cil	35000	41000	2024-11-26 05:25:23.892	2024-11-26 08:54:49.689	5000	cm3y80z8a005o11m20wlrrkl4	2024-11-26 08:54:49.689	2024-11-26 08:54:49.689
cm3y84f5h005w11m2pdbvz9aa	cm3xuj38h00kk7jwwnwywtik2	50000	55000	2024-11-26 03:18:21.192	2024-11-26 08:57:30.293	\N	\N	2024-11-26 08:57:30.293	2024-11-26 08:57:30.293
\.


--
-- Data for Name: SalaryIncreaseEvent; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."SalaryIncreaseEvent" ("id", "percentage", "amount", "appliedAt", "appliedBy", "isUndone", "undoneAt", "undoneBy") FROM stdin;
cm3wmqo9x000tryyfg0rdz5a1	\N	1000	2024-11-25 06:11:10.811	emman	f	\N	\N
cm3xxv78802ql7jwwmfx37gty	\N	5000	2024-11-26 04:10:23.96	emman	f	\N	\N
cm3y0jnec02vr7jwwop8jdffm	\N	1000	2024-11-26 05:25:23.892	emman	f	\N	\N
cm3y5noyz000b12cwkp7xd22s	\N	-4000	2024-11-26 07:48:30.628	emman	f	\N	\N
cm3y5ohay000h12cwmvalvcfa	\N	4000	2024-11-26 07:49:07.347	emman	f	\N	\N
cm3y63mki000311m2kxik3i9q	\N	1000	2024-11-26 08:00:54.011	emman	f	\N	\N
cm3y80z8a005o11m20wlrrkl4	\N	5000	2024-11-26 08:54:49.689	emman	f	\N	\N
\.


--
-- Data for Name: Timesheet; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."Timesheet" ("id", "userId", "dayId", "clockIn", "clockOut", "isLate", "isOvertime", "forgotClockOut", "clockOutEarly", "isLeave", "isAdvanced", "clockOutEarlyMinutes", "minutesOvertime", "minutesLate", "payrollItemId", "createdAt", "updatedAt") FROM stdin;
cm3xpfpsk00f77jwww0udziym	emman	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xw9y3j00s87jww5308s3vt	cm3xu8bx700jn7jwwlfh8k68g	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3m00sa7jwwn7jdmjxo	cm3xu8bx700jn7jwwlfh8k68g	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3p00sc7jwwjxy98m3o	cm3xu8bx700jn7jwwlfh8k68g	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3r00se7jww9e3a2zzj	cm3xu8bx700jn7jwwlfh8k68g	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3t00sg7jwwgwzvj1td	cm3xu8bx700jn7jwwlfh8k68g	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3x00si7jwwrcak4kkm	cm3xu8bx700jn7jwwlfh8k68g	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y3y00sk7jwwryv7s2uv	cm3xu8bx700jn7jwwlfh8k68g	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4100sm7jwwi9xjh9gc	cm3xu8bx700jn7jwwlfh8k68g	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4200so7jwwg87vgqv8	cm3xu8bx700jn7jwwlfh8k68g	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4400sq7jwwzijwsf45	cm3xu8bx700jn7jwwlfh8k68g	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xpfpnf009f7jwwb36pm48p	cm3sd6n7y000h98xyfpmb6any	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnh009h7jwwe03w64tl	cm3sd6n7y000h98xyfpmb6any	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnj009j7jww7fg6wegu	cm3sd6n7y000h98xyfpmb6any	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnl009l7jwws8vpbsbx	cm3sd6n7y000h98xyfpmb6any	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnm009n7jww7tjgethz	cm3sd6n7y000h98xyfpmb6any	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpno009p7jww0g2xhrae	cm3sd6n7y000h98xyfpmb6any	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnr009r7jww40t8pni9	cm3sd6n7y000h98xyfpmb6any	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpns009t7jwwu4answuf	cm3sd6n7y000h98xyfpmb6any	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfppb00bj7jwwrupd0qjz	cm3sd5sob000698xytgsayvvu	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfpmw008z7jwwh4l5kqwx	cm3sd6n7y000h98xyfpmb6any	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpmz00917jwwwmg854yp	cm3sd6n7y000h98xyfpmb6any	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpn200937jww4z9cvnam	cm3sd6n7y000h98xyfpmb6any	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpn400957jwwmrnay56e	cm3sd6n7y000h98xyfpmb6any	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpn700977jww5wltkyy5	cm3sd6n7y000h98xyfpmb6any	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpn900997jwwhg9zrtgb	cm3sd6n7y000h98xyfpmb6any	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpnc009b7jwweq9ip82z	cm3sd6n7y000h98xyfpmb6any	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpne009d7jwwf4zdety2	cm3sd6n7y000h98xyfpmb6any	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayrk02kv7jwwfrgzrudz	2024-11-26 00:14:24.378	2024-11-26 03:26:40.256
cm3xpfpoy00b37jwwmndat5ju	cm3sd5sob000698xytgsayvvu	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpoz00b57jwwrs5k2n20	cm3sd5sob000698xytgsayvvu	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp100b77jww67b02ctt	cm3sd5sob000698xytgsayvvu	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp200b97jwwvfbh6e37	cm3sd5sob000698xytgsayvvu	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp500bb7jwwym6ulbfq	cm3sd5sob000698xytgsayvvu	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp600bd7jwwfxomx8bs	cm3sd5sob000698xytgsayvvu	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp800bf7jwwyretrve3	cm3sd5sob000698xytgsayvvu	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xpfpp900bh7jww9z60jwe4	cm3sd5sob000698xytgsayvvu	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xways102l97jwwcr64dd2o	2024-11-26 00:14:24.378	2024-11-26 03:26:40.272
cm3xw9zes01ym7jww592he5vk	cm3xvamu600mp7jwwmgb1kf5e	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9y4800ss7jww5xxvjt1i	cm3xu8bx700jn7jwwlfh8k68g	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4a00su7jwwp5s0e0py	cm3xu8bx700jn7jwwlfh8k68g	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4c00sw7jwwpz3zafjn	cm3xu8bx700jn7jwwlfh8k68g	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4e00sy7jwwjwx5d4wo	cm3xu8bx700jn7jwwlfh8k68g	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4h00t07jwwv6sj0z5r	cm3xu8bx700jn7jwwlfh8k68g	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4k00t27jwwv2jryvdl	cm3xu8bx700jn7jwwlfh8k68g	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4l00t47jwwqloed6ei	cm3xu8bx700jn7jwwlfh8k68g	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y4n00t67jwwqhkbgyaw	cm3xu8bx700jn7jwwlfh8k68g	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xpfprq00e97jwwmy8z62or	emman	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfppe00bl7jwwchtdlflp	cm3sd5sob000698xytgsayvvu	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppg00bn7jww8l43juu2	cm3sd5sob000698xytgsayvvu	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfpph00bp7jwwz54fkrri	cm3sd5sob000698xytgsayvvu	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppj00br7jwwto2pz0rj	cm3sd5sob000698xytgsayvvu	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppk00bt7jwwv1jjaf5m	cm3sd5sob000698xytgsayvvu	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppn00bv7jww24y6u7bw	cm3sd5sob000698xytgsayvvu	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppp00bx7jwwiv1fqnze	cm3sd5sob000698xytgsayvvu	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfpr700dn7jwwsumhx5j3	emman	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfpr900dp7jwwzcol0xku	emman	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfpra00dr7jwwrcn4t19a	emman	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprc00dt7jwwpcmmsf8h	emman	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprd00dv7jwwljj7m8or	emman	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprf00dx7jwwy9mfcafm	emman	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprh00dz7jwwk2nw26qg	emman	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprj00e17jwwyfeuz63q	emman	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprl00e37jwwe0lw0cu4	emman	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfprm00e57jwwp7zz4fq6	emman	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xpfpro00e77jwwj34226zn	emman	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbs02g87jwwkunjnumr	2024-11-26 00:14:24.378	2024-11-26 03:26:29.32
cm3xw9y4p00t87jwwqdwgw52q	cm3xu8bx700jn7jwwlfh8k68g	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y4r00ta7jww2cdluas3	cm3xu8bx700jn7jwwlfh8k68g	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xpfpqt00d77jww28afr0mh	emman	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpqv00d97jww19lvxgp5	emman	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpqx00db7jwwh1456rib	emman	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpqy00dd7jwwx5upskiv	emman	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpr100df7jwwjc00osz6	emman	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpr200dh7jww5yv9s19u	emman	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpr400dj7jwwd3jfs76k	emman	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xw9z6k01ri7jwwwahoh015	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z2d01ns7jwwx336ykj5	cm3xvd52v00n07jwwu9txe547	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2f01nu7jwwlacofqa6	cm3xvd52v00n07jwwu9txe547	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2h01nw7jwwe28qnopg	cm3xvd52v00n07jwwu9txe547	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2l01ny7jww7wi9tfp3	cm3xvd52v00n07jwwu9txe547	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9yui01gs7jwwtzn931zm	cm3xuz9oj00lh7jww07cy3cil	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yul01gu7jwwg4xz1xop	cm3xuz9oj00lh7jww07cy3cil	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xpfprs00eb7jwwwh9pppup	emman	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfprt00ed7jwwl4gi351u	emman	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfprv00ef7jww8tytibk5	emman	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfpry00eh7jwwrjcrzejl	emman	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfps000ej7jwwb88o6b52	emman	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfps100el7jww46ozqtbe	emman	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfps300en7jwwssdjo8yi	emman	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xpfps400ep7jwwt69o0tw6	emman	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9r302az7jwwvm765rjf	2024-11-26 00:14:24.378	2024-11-26 03:26:07.839
cm3xw9y5e00tu7jwwt078zkjk	cm3xu8bx700jn7jwwlfh8k68g	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5h00tw7jwwhf3i6qnh	cm3xu8bx700jn7jwwlfh8k68g	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5j00ty7jwwhtdv0pt1	cm3xu8bx700jn7jwwlfh8k68g	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5l00u07jwwqxyoyjkw	cm3xu8bx700jn7jwwlfh8k68g	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5n00u27jww4fr4vnb3	cm3xu8bx700jn7jwwlfh8k68g	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5p00u47jwwixdclw01	cm3xu8bx700jn7jwwlfh8k68g	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5t00u67jwwycjlpq5o	cm3xu8bx700jn7jwwlfh8k68g	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y4w00tc7jwwh2pskk3n	cm3xu8bx700jn7jwwlfh8k68g	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y4y00te7jwwaony4mkv	cm3xu8bx700jn7jwwlfh8k68g	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5000tg7jww2qbr1f9c	cm3xu8bx700jn7jwwlfh8k68g	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5200ti7jwwj559m3hs	cm3xu8bx700jn7jwwlfh8k68g	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5400tk7jwwx496eyo7	cm3xu8bx700jn7jwwlfh8k68g	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5700tm7jwwhd3twhuu	cm3xu8bx700jn7jwwlfh8k68g	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5900to7jwwcnql9sm1	cm3xu8bx700jn7jwwlfh8k68g	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5a00tq7jww3pdj2lx8	cm3xu8bx700jn7jwwlfh8k68g	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9y5c00ts7jwwmh96omju	cm3xu8bx700jn7jwwlfh8k68g	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaylh02gl7jwwazny1fhb	2024-11-26 03:25:52.719	2024-11-26 03:26:40.037
cm3xw9yit01647jwwn1kwl8cg	cm3xuoj8d00kv7jwwop9hwrrk	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yiv01667jwwdo0rhdxh	cm3xuoj8d00kv7jwwop9hwrrk	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xpfpoh00al7jwwgvzgnyvr	cm3sd6n7y000h98xyfpmb6any	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xpfpoi00an7jwwuvnnydgu	cm3sd6n7y000h98xyfpmb6any	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xpfpok00ap7jwwczgbecof	cm3sd6n7y000h98xyfpmb6any	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xpfpom00ar7jww1uefyhm9	cm3sd6n7y000h98xyfpmb6any	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xpfpop00at7jww8brogkji	cm3sd6n7y000h98xyfpmb6any	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xw9y6r00v07jwwclofzx30	cm3xu8bx700jn7jwwlfh8k68g	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9yqm01d67jwwpc0boe50	cm3xusu1p00l67jwwmm29up9j	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqo01d87jwwfabx2vpr	cm3xusu1p00l67jwwmm29up9j	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqs01da7jwws4z20b7g	cm3xusu1p00l67jwwmm29up9j	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9y7r00vk7jwwqtpsw7s4	cm3xu8bx700jn7jwwlfh8k68g	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y7t00vm7jwwvks3v0w9	cm3xu8bx700jn7jwwlfh8k68g	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y7v00vo7jww3nl0xtyt	cm3xu8bx700jn7jwwlfh8k68g	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y7x00vq7jwwk3fjjj30	cm3xu8bx700jn7jwwlfh8k68g	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8100vs7jww177746xw	cm3xuj38h00kk7jwwnwywtik2	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8300vu7jww68w3tn1p	cm3xuj38h00kk7jwwnwywtik2	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8500vw7jwwlauvio18	cm3xuj38h00kk7jwwnwywtik2	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8700vy7jwwy338byos	cm3xuj38h00kk7jwwnwywtik2	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8900w07jww7flwxqvs	cm3xuj38h00kk7jwwnwywtik2	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8c00w27jwwdt62xzgg	cm3xuj38h00kk7jwwnwywtik2	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8f00w47jwwoyk3u5oc	cm3xuj38h00kk7jwwnwywtik2	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8h00w67jwwczg6te2h	cm3xuj38h00kk7jwwnwywtik2	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8k00w87jwwik5qr19q	cm3xuj38h00kk7jwwnwywtik2	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8m00wa7jwwo3djrg22	cm3xuj38h00kk7jwwnwywtik2	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8p00wc7jwwcif3y0vh	cm3xuj38h00kk7jwwnwywtik2	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8r00we7jwwir6hutiv	cm3xuj38h00kk7jwwnwywtik2	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8u00wg7jwwl5yyu0f6	cm3xuj38h00kk7jwwnwywtik2	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8w00wi7jwwemxm4qa0	cm3xuj38h00kk7jwwnwywtik2	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y8y00wk7jwwzd0k8m24	cm3xuj38h00kk7jwwnwywtik2	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y9100wm7jwwjhcwnfyg	cm3xuj38h00kk7jwwnwywtik2	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y9300wo7jww58ffgbju	cm3xuj38h00kk7jwwnwywtik2	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y9400wq7jwwm3cdyyni	cm3xuj38h00kk7jwwnwywtik2	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zam01v07jwwg7oeu39k	cm3xv6vyj00me7jww8fatnd46	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zap01v27jww6e6w9e5e	cm3xv6vyj00me7jww8fatnd46	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xpfpor00av7jww46tfhoag	cm3sd6n7y000h98xyfpmb6any	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xw9yax00yi7jwwwfhe66zj	cm3xuj38h00kk7jwwnwywtik2	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yaz00yk7jwwat0d0dgr	cm3xuj38h00kk7jwwnwywtik2	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yb100ym7jwwqplpobbh	cm3xuj38h00kk7jwwnwywtik2	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yb200yo7jwwc8graxix	cm3xuj38h00kk7jwwnwywtik2	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yb400yq7jwwi3nj1oi7	cm3xuj38h00kk7jwwnwywtik2	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yb700ys7jwwvkxrg22a	cm3xuj38h00kk7jwwnwywtik2	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yb900yu7jww5v5oj628	cm3xuj38h00kk7jwwnwywtik2	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yba00yw7jwwd4lzpzcv	cm3xuj38h00kk7jwwnwywtik2	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y9r00xe7jwwt2tozfwr	cm3xuj38h00kk7jwwnwywtik2	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9y9v00xg7jwwfadix0v3	cm3xuj38h00kk7jwwnwywtik2	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9y9w00xi7jwwgzb7aq6g	cm3xuj38h00kk7jwwnwywtik2	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9y9y00xk7jwwipg7t58o	cm3xuj38h00kk7jwwnwywtik2	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9y9z00xm7jww9enxi71z	cm3xuj38h00kk7jwwnwywtik2	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9ya100xo7jww0tniobrd	cm3xuj38h00kk7jwwnwywtik2	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9ya300xq7jwwo5fjhoqx	cm3xuj38h00kk7jwwnwywtik2	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9ya600xs7jwwhfe05yfs	cm3xuj38h00kk7jwwnwywtik2	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9y9600ws7jwwhkjxi22a	cm3xuj38h00kk7jwwnwywtik2	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9800wu7jwwvfd6udw2	cm3xuj38h00kk7jwwnwywtik2	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9b00ww7jww1m2kicmp	cm3xuj38h00kk7jwwnwywtik2	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9c00wy7jwwhmv8m68h	cm3xuj38h00kk7jwwnwywtik2	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9e00x07jwwgeq3zaic	cm3xuj38h00kk7jwwnwywtik2	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9f00x27jwwz1emmdg8	cm3xuj38h00kk7jwwnwywtik2	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9h00x47jwwjz6q76fc	cm3xuj38h00kk7jwwnwywtik2	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9l00x67jwwhsbt6kjm	cm3xuj38h00kk7jwwnwywtik2	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9m00x87jww9cnnchs0	cm3xuj38h00kk7jwwnwywtik2	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9y9o00xa7jwwul0g05c5	cm3xuj38h00kk7jwwnwywtik2	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xpfpou00ax7jwwpj4ncd8c	cm3sd6n7y000h98xyfpmb6any	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xw9ybc00yy7jww1fka65s3	cm3xuj38h00kk7jwwnwywtik2	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybd00z07jwws78jccso	cm3xuj38h00kk7jwwnwywtik2	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybg00z27jww3jjwb8jh	cm3xuj38h00kk7jwwnwywtik2	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybj00z47jwwbk0dycxh	cm3xuj38h00kk7jwwnwywtik2	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybk00z67jwwz9aomr1u	cm3xuj38h00kk7jwwnwywtik2	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybl00z87jww1z3htnsl	cm3xuj38h00kk7jwwnwywtik2	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybn00za7jwwszrmz7gl	cm3xuj38h00kk7jwwnwywtik2	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybp00zc7jwwy9i54xwi	cm3xud7bl00jy7jww9qzfi51c	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybr00ze7jwwaghtyv0h	cm3xud7bl00jy7jww9qzfi51c	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybt00zg7jwwc7nsxj1j	cm3xud7bl00jy7jww9qzfi51c	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybv00zi7jwwaw0h8j1g	cm3xud7bl00jy7jww9qzfi51c	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybw00zk7jww99tytsfg	cm3xud7bl00jy7jww9qzfi51c	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ybz00zm7jwweqtaqol9	cm3xud7bl00jy7jww9qzfi51c	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yc100zo7jwws8b9k0md	cm3xud7bl00jy7jww9qzfi51c	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yc300zq7jww8rflpumi	cm3xud7bl00jy7jww9qzfi51c	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yc500zs7jwwkh6yar0n	cm3xud7bl00jy7jww9qzfi51c	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yc700zu7jwwswerawy3	cm3xud7bl00jy7jww9qzfi51c	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yca00zw7jww43hzrpr5	cm3xud7bl00jy7jww9qzfi51c	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ycc00zy7jww135bvvk8	cm3xud7bl00jy7jww9qzfi51c	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yce01007jwwxcsj3vy1	cm3xud7bl00jy7jww9qzfi51c	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ycg01027jwwbcc44kbh	cm3xud7bl00jy7jww9qzfi51c	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yci01047jwwpzdyw1f1	cm3xud7bl00jy7jww9qzfi51c	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ycl01067jww3mumwwmd	cm3xud7bl00jy7jww9qzfi51c	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ycn01087jww38o09xkl	cm3xud7bl00jy7jww9qzfi51c	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ycp010a7jwwy2s1rfpo	cm3xud7bl00jy7jww9qzfi51c	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3y7squc000o11m26lx823gi	emman	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	\N	t	f	f	f	f	f	0	0	513	\N	2024-11-26 08:48:25.572	2024-11-26 08:48:25.572
cm3xpfpof00aj7jwwwa9r51ft	cm3sd6n7y000h98xyfpmb6any	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xw9ycq010c7jwwax4aftdb	cm3xud7bl00jy7jww9qzfi51c	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9ycs010e7jww0x12ckgx	cm3xud7bl00jy7jww9qzfi51c	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9ycw010g7jww851syxb0	cm3xud7bl00jy7jww9qzfi51c	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9ycy010i7jwwpsjy7h94	cm3xud7bl00jy7jww9qzfi51c	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9ycz010k7jwwd2x9sr3o	cm3xud7bl00jy7jww9qzfi51c	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yd1010m7jwwmt2tskix	cm3xud7bl00jy7jww9qzfi51c	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yd3010o7jwwvi2v1aqu	cm3xud7bl00jy7jww9qzfi51c	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yd6010q7jww9tmg3wj7	cm3xud7bl00jy7jww9qzfi51c	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yd9010s7jwwdfix2q5f	cm3xud7bl00jy7jww9qzfi51c	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yda010u7jww8rxqlo0r	cm3xud7bl00jy7jww9qzfi51c	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yyc01ke7jwwefa50gpq	cm3xv4w6000m37jww5tkffps0	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9y7400v27jww55g5gs19	cm3xu8bx700jn7jwwlfh8k68g	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9yek01227jwweyu56xky	cm3xud7bl00jy7jww9qzfi51c	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yem01247jww6x2zbsks	cm3xud7bl00jy7jww9qzfi51c	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yen01267jww6hx57a9p	cm3xud7bl00jy7jww9qzfi51c	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yep01287jwwb4gs35jy	cm3xud7bl00jy7jww9qzfi51c	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xpfpow00az7jwwvu3j6qq0	cm3sd6n7y000h98xyfpmb6any	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
cm3xw9yf6012o7jwwmm95tdkl	cm3xud7bl00jy7jww9qzfi51c	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yf9012q7jwws81ud9do	cm3xud7bl00jy7jww9qzfi51c	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfa012s7jww5lvvk81f	cm3xud7bl00jy7jww9qzfi51c	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfc012u7jwwevqgcgd2	cm3xud7bl00jy7jww9qzfi51c	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yff012w7jwwvcemde5e	cm3xuoj8d00kv7jwwop9hwrrk	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfg012y7jwwop253m6o	cm3xuoj8d00kv7jwwop9hwrrk	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfi01307jwwf2sk5yxu	cm3xuoj8d00kv7jwwop9hwrrk	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfk01327jwwiablfk6m	cm3xuoj8d00kv7jwwop9hwrrk	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfm01347jwwyqaenojv	cm3xuoj8d00kv7jwwop9hwrrk	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfp01367jwwef8z4yt1	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfr01387jwwgffr36h1	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yft013a7jww6e9imulb	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfu013c7jwws7hcc7fk	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yfw013e7jwww19ejxpx	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yg0013g7jww2lrtv4xb	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yg2013i7jwws3jbqn23	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yg3013k7jwwkygr0ji6	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yg5013m7jww97aak0h4	cm3xuoj8d00kv7jwwop9hwrrk	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yg7013o7jwwa3evdmw5	cm3xuoj8d00kv7jwwop9hwrrk	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ygb013q7jwwl3dsmnzf	cm3xuoj8d00kv7jwwop9hwrrk	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ygd013s7jww4mc4050b	cm3xuoj8d00kv7jwwop9hwrrk	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yge013u7jwwelqgm2s0	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ygg013w7jwwy1pv5mct	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygi013y7jwwkreri2jn	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygl01407jwwvicqu1rx	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygn01427jwwe2bvuajj	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygp01447jwwddqqf0p8	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9y6q00uy7jwwihcyn0fo	cm3xu8bx700jn7jwwlfh8k68g	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7l00vg7jwwgjxhu239	cm3xu8bx700jn7jwwlfh8k68g	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7p00vi7jwwnrklmqgt	cm3xu8bx700jn7jwwlfh8k68g	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9yib015m7jww2ee9hlij	cm3xuoj8d00kv7jwwop9hwrrk	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yid015o7jwwn898thby	cm3xuoj8d00kv7jwwop9hwrrk	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yif015q7jwwg05wlds3	cm3xuoj8d00kv7jwwop9hwrrk	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yih015s7jwwa1k7jw5z	cm3xuoj8d00kv7jwwop9hwrrk	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yii015u7jwwf58d7lou	cm3xuoj8d00kv7jwwop9hwrrk	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yil015w7jwwl70hkega	cm3xuoj8d00kv7jwwop9hwrrk	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yin015y7jwwnu2oq91u	cm3xuoj8d00kv7jwwop9hwrrk	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yip01607jwwfjt4vwds	cm3xuoj8d00kv7jwwop9hwrrk	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yir01627jwwkdtv43f2	cm3xuoj8d00kv7jwwop9hwrrk	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4z002a11m20u8h9422	2024-11-26 03:25:52.719	2024-11-26 08:52:47.747
cm3xw9yix01687jwwptjooj61	cm3xuoj8d00kv7jwwop9hwrrk	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yiz016a7jww6wkqac7e	cm3xuoj8d00kv7jwwop9hwrrk	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yj1016c7jwwmtz5k4jc	cm3xuoj8d00kv7jwwop9hwrrk	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yj3016e7jwwmfmux52o	cm3xuoj8d00kv7jwwop9hwrrk	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yj6016g7jwwy4xt5mtg	cm3xufw6p00k97jww8n9qq7fq	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yj8016i7jwwbmpj6dt9	cm3xufw6p00k97jww8n9qq7fq	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yj9016k7jww6y49pnke	cm3xufw6p00k97jww8n9qq7fq	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjb016m7jww46l0c22n	cm3xufw6p00k97jww8n9qq7fq	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjd016o7jwwc6m1pauw	cm3xufw6p00k97jww8n9qq7fq	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjh016q7jww11x8y0c8	cm3xufw6p00k97jww8n9qq7fq	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yh3014i7jwwcjqzbriz	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yh6014k7jww43f93yuw	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yh7014m7jwwvp7vb4pa	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yh9014o7jwwx5k1mgm2	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yhc014q7jwwsnin3oxc	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yhd014s7jwwir7wa0le	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yhg014u7jww10yjf8dm	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yhi014w7jwwr4gpw1ib	cm3xuoj8d00kv7jwwop9hwrrk	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9ygq01467jww51e785ix	cm3xuoj8d00kv7jwwop9hwrrk	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygs01487jww1513a6u2	cm3xuoj8d00kv7jwwop9hwrrk	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygv014a7jwwgf7fe517	cm3xuoj8d00kv7jwwop9hwrrk	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9ygx014c7jwwvhq07b1a	cm3xuoj8d00kv7jwwop9hwrrk	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9yh0014e7jww7glw6e89	cm3xuoj8d00kv7jwwop9hwrrk	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9yh1014g7jwwxtnq7skg	cm3xuoj8d00kv7jwwop9hwrrk	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymx02hi7jwwr7yo62cl	2024-11-26 03:25:52.719	2024-11-26 03:26:40.089
cm3xw9yeq012a7jwwbufc8du1	cm3xud7bl00jy7jww9qzfi51c	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yet012c7jwwrne9hgnx	cm3xud7bl00jy7jww9qzfi51c	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yji016s7jwwwj84rwj4	cm3xufw6p00k97jww8n9qq7fq	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjk016u7jww6mbrx8sz	cm3xufw6p00k97jww8n9qq7fq	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjm016w7jwwf0tn4o96	cm3xufw6p00k97jww8n9qq7fq	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjo016y7jwwa6c6afq4	cm3xufw6p00k97jww8n9qq7fq	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjr01707jww8bqtjyj7	cm3xufw6p00k97jww8n9qq7fq	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjt01727jww4ybocey6	cm3xufw6p00k97jww8n9qq7fq	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjv01747jww2l1fxp1k	cm3xufw6p00k97jww8n9qq7fq	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjw01767jwwpshze65w	cm3xufw6p00k97jww8n9qq7fq	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yjy01787jww1mnstsyn	cm3xufw6p00k97jww8n9qq7fq	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yk1017a7jwwulhekcxf	cm3xufw6p00k97jww8n9qq7fq	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yk2017c7jwwknns0pf9	cm3xufw6p00k97jww8n9qq7fq	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yk4017e7jwwp2w1qwf7	cm3xufw6p00k97jww8n9qq7fq	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yev012e7jww6haucab7	cm3xud7bl00jy7jww9qzfi51c	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yex012g7jwwp12e0l96	cm3xud7bl00jy7jww9qzfi51c	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yez012i7jwwc1bynnye	cm3xud7bl00jy7jww9qzfi51c	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yf1012k7jww54u02ywk	cm3xud7bl00jy7jww9qzfi51c	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9ylx01967jwwxdrolzoq	cm3xufw6p00k97jww8n9qq7fq	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ylz01987jwws9mrv0kf	cm3xufw6p00k97jww8n9qq7fq	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ym0019a7jwwjeguwkaa	cm3xufw6p00k97jww8n9qq7fq	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ym3019c7jwwil7961g1	cm3xufw6p00k97jww8n9qq7fq	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9yf4012m7jwwg2inaxka	cm3xud7bl00jy7jww9qzfi51c	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd59002l11m2caqkukyt	2024-11-26 03:25:52.719	2024-11-26 08:52:47.757
cm3xw9yku01827jwwh8cd4foi	cm3xufw6p00k97jww8n9qq7fq	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9ykx01847jwwxvvm3lyx	cm3xufw6p00k97jww8n9qq7fq	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9ykz01867jww5gdgz77b	cm3xufw6p00k97jww8n9qq7fq	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yl001887jwwebkoqdw5	cm3xufw6p00k97jww8n9qq7fq	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yl2018a7jww0rrfy8fx	cm3xufw6p00k97jww8n9qq7fq	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yl4018c7jwwhe7gs9ak	cm3xufw6p00k97jww8n9qq7fq	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yl7018e7jwwiur17d5z	cm3xufw6p00k97jww8n9qq7fq	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yl8018g7jwwpwd5x0qu	cm3xufw6p00k97jww8n9qq7fq	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yk6017g7jww95df3356	cm3xufw6p00k97jww8n9qq7fq	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9yk8017i7jww63holnp5	cm3xufw6p00k97jww8n9qq7fq	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykb017k7jwwnrgslwie	cm3xufw6p00k97jww8n9qq7fq	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykd017m7jwwb9yzqsc6	cm3xufw6p00k97jww8n9qq7fq	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykf017o7jwwqs6cncfk	cm3xufw6p00k97jww8n9qq7fq	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9yki017q7jwwrgh3nzdj	cm3xufw6p00k97jww8n9qq7fq	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykk017s7jww5kn9angd	cm3xufw6p00k97jww8n9qq7fq	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykn017u7jwwk3owi4a8	cm3xufw6p00k97jww8n9qq7fq	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9yko017w7jwwh2i1b6hi	cm3xufw6p00k97jww8n9qq7fq	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9ykq017y7jwwmzrh9mbb	cm3xufw6p00k97jww8n9qq7fq	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xpfpsl00f97jwwd3zfiez9	emman	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xw9ymy019s7jwwgjtkxppp	cm3xufw6p00k97jww8n9qq7fq	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ymz019u7jww37mc832j	cm3xufw6p00k97jww8n9qq7fq	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yn1019w7jww5vdjkv1e	cm3xufw6p00k97jww8n9qq7fq	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yn3019y7jwwkwfuq4p9	cm3xufw6p00k97jww8n9qq7fq	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yn601a07jwwcggokdb7	cm3xusu1p00l67jwwmm29up9j	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yn701a27jwwqoq7lcd0	cm3xusu1p00l67jwwmm29up9j	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yn901a47jwwiee2j8aq	cm3xusu1p00l67jwwmm29up9j	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynb01a67jwwpj8rmi17	cm3xusu1p00l67jwwmm29up9j	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ync01a87jww82480fhf	cm3xusu1p00l67jwwmm29up9j	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynf01aa7jwwjp4qs4gm	cm3xusu1p00l67jwwmm29up9j	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yni01ac7jww284qeums	cm3xusu1p00l67jwwmm29up9j	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynj01ae7jwwpphmms4o	cm3xusu1p00l67jwwmm29up9j	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynl01ag7jww6k1glvs7	cm3xusu1p00l67jwwmm29up9j	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynn01ai7jww2s3z1u9p	cm3xusu1p00l67jwwmm29up9j	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynq01ak7jww5qnyckyp	cm3xusu1p00l67jwwmm29up9j	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yns01am7jww7iameicd	cm3xusu1p00l67jwwmm29up9j	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynu01ao7jww01ksfhi6	cm3xusu1p00l67jwwmm29up9j	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ynw01aq7jwwcvnlhzpc	cm3xusu1p00l67jwwmm29up9j	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yny01as7jwwgwnsh0v2	cm3xusu1p00l67jwwmm29up9j	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yo101au7jww26rffyyj	cm3xusu1p00l67jwwmm29up9j	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yo301aw7jwwuaintyfn	cm3xusu1p00l67jwwmm29up9j	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yo501ay7jwwohxqc3fn	cm3xusu1p00l67jwwmm29up9j	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ym4019e7jwwxrxns977	cm3xufw6p00k97jww8n9qq7fq	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9yml019g7jwwlv02pfab	cm3xufw6p00k97jww8n9qq7fq	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ymm019i7jwwmybiurg3	cm3xufw6p00k97jww8n9qq7fq	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ymo019k7jwwz5zaz234	cm3xufw6p00k97jww8n9qq7fq	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ymq019m7jwwrtqw8m9c	cm3xufw6p00k97jww8n9qq7fq	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ymt019o7jwwg4exwua0	cm3xufw6p00k97jww8n9qq7fq	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9ymw019q7jwwk5kaea6d	cm3xufw6p00k97jww8n9qq7fq	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5q003711m2llgml1z2	2024-11-26 03:25:52.719	2024-11-26 08:52:47.774
cm3xw9yo801b07jwwko9qz95b	cm3xusu1p00l67jwwmm29up9j	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yoa01b27jwwx12xnhq6	cm3xusu1p00l67jwwmm29up9j	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yod01b47jwwvevhc7sf	cm3xusu1p00l67jwwmm29up9j	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yoe01b67jww41h0dje3	cm3xusu1p00l67jwwmm29up9j	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yog01b87jww8va4672t	cm3xusu1p00l67jwwmm29up9j	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yoh01ba7jwwwwpk9fm1	cm3xusu1p00l67jwwmm29up9j	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9y7600v47jwwgznnjozt	cm3xu8bx700jn7jwwlfh8k68g	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7b00v67jwwa6d9cbxn	cm3xu8bx700jn7jwwlfh8k68g	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7e00v87jwwk1o5kzmn	cm3xu8bx700jn7jwwlfh8k68g	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7f00va7jww9rkkn3g2	cm3xu8bx700jn7jwwlfh8k68g	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7h00vc7jwwy25d8zdt	cm3xu8bx700jn7jwwlfh8k68g	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9y7j00ve7jww7ck03jw2	cm3xu8bx700jn7jwwlfh8k68g	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6x004q11m2uxc3nqdw	2024-11-26 03:25:52.719	2024-11-26 08:52:47.817
cm3xw9yq601cq7jww9ebx5u3g	cm3xusu1p00l67jwwmm29up9j	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yq701cs7jwwrc2kk0ad	cm3xusu1p00l67jwwmm29up9j	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yq901cu7jwwzzthgfxq	cm3xusu1p00l67jwwmm29up9j	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqb01cw7jww4y0nqf86	cm3xusu1p00l67jwwmm29up9j	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqd01cy7jwwmo61cslx	cm3xusu1p00l67jwwmm29up9j	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqu01dc7jww20643mwp	cm3xusu1p00l67jwwmm29up9j	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yqv01de7jwwb19nw4ea	cm3xusu1p00l67jwwmm29up9j	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yqx01dg7jwwpjkbrng8	cm3xusu1p00l67jwwmm29up9j	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yqz01di7jwwdv3u4tfj	cm3xusu1p00l67jwwmm29up9j	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yr201dk7jww1g0i7s6t	cm3xuz9oj00lh7jww07cy3cil	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yr401dm7jwwi7pzzmzx	cm3xuz9oj00lh7jww07cy3cil	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yr501do7jww1so6cz6n	cm3xuz9oj00lh7jww07cy3cil	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yr701dq7jwwkt0u54bn	cm3xuz9oj00lh7jww07cy3cil	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yr801ds7jwwbd9s82bz	cm3xuz9oj00lh7jww07cy3cil	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrb01du7jwwz6gg17ao	cm3xuz9oj00lh7jww07cy3cil	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrd01dw7jwwn3wg0rgt	cm3xuz9oj00lh7jww07cy3cil	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrf01dy7jwwkffiekln	cm3xuz9oj00lh7jww07cy3cil	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrh01e07jww8hbx2rzv	cm3xuz9oj00lh7jww07cy3cil	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yri01e27jwwjonwd18m	cm3xuz9oj00lh7jww07cy3cil	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrl01e47jwwwnpn0zxb	cm3xuz9oj00lh7jww07cy3cil	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrn01e67jwwjjv2dhi6	cm3xuz9oj00lh7jww07cy3cil	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrp01e87jwwb2sawz9y	cm3xuz9oj00lh7jww07cy3cil	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrr01ea7jww4ne2p1i9	cm3xuz9oj00lh7jww07cy3cil	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrs01ec7jwwwbhm0gj4	cm3xuz9oj00lh7jww07cy3cil	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrv01ee7jwwtu98hryk	cm3xuz9oj00lh7jww07cy3cil	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrx01eg7jww813r7fq0	cm3xuz9oj00lh7jww07cy3cil	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yrz01ei7jwwqg4nr2p3	cm3xuz9oj00lh7jww07cy3cil	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ypb01c07jwwwhqtcu7l	cm3xusu1p00l67jwwmm29up9j	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9ypd01c27jww2w6txwu3	cm3xusu1p00l67jwwmm29up9j	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9ypf01c47jwwxf20hq2p	cm3xusu1p00l67jwwmm29up9j	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yph01c67jwwrr1ru1na	cm3xusu1p00l67jwwmm29up9j	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9ys101ek7jww8y0nutmf	cm3xuz9oj00lh7jww07cy3cil	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9yqg01d07jwwyhrnx2kh	cm3xusu1p00l67jwwmm29up9j	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yqi01d27jww1rc61peo	cm3xusu1p00l67jwwmm29up9j	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9ytz01ga7jwwlwq975ke	cm3xuz9oj00lh7jww07cy3cil	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yu101gc7jwwwwdmplgy	cm3xuz9oj00lh7jww07cy3cil	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yu301ge7jwwutk98pof	cm3xuz9oj00lh7jww07cy3cil	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yu501gg7jww30ovttm8	cm3xuz9oj00lh7jww07cy3cil	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yu701gi7jwwaq5qyyjb	cm3xuz9oj00lh7jww07cy3cil	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yub01gk7jww8zna2i3o	cm3xuz9oj00lh7jww07cy3cil	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yuc01gm7jwwe4awejl4	cm3xuz9oj00lh7jww07cy3cil	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yue01go7jww529guvnu	cm3xuz9oj00lh7jww07cy3cil	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yug01gq7jww51utdev3	cm3xuz9oj00lh7jww07cy3cil	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd74005111m2j15yehv7	2024-11-26 03:25:52.719	2024-11-26 08:52:47.824
cm3xw9yun01gw7jww5w47md75	cm3xuz9oj00lh7jww07cy3cil	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yup01gy7jwwz8m7l2dw	cm3xuz9oj00lh7jww07cy3cil	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yur01h07jwwhtl0rkpv	cm3xuz9oj00lh7jww07cy3cil	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yut01h27jwwcddzzq3q	cm3xuz9oj00lh7jww07cy3cil	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yuv01h47jwwkuubybj9	cm3xv4w6000m37jww5tkffps0	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yux01h67jwwia1xhotb	cm3xv4w6000m37jww5tkffps0	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yss01f67jwwoo8yfa9y	cm3xuz9oj00lh7jww07cy3cil	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ysw01f87jwwn2m72euj	cm3xuz9oj00lh7jww07cy3cil	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ysx01fa7jwwglcwomwm	cm3xuz9oj00lh7jww07cy3cil	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ysz01fc7jwwkjqwpw5p	cm3xuz9oj00lh7jww07cy3cil	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9yt001fe7jwwqpzufbo6	cm3xuz9oj00lh7jww07cy3cil	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9yt201fg7jww88l5eerj	cm3xuz9oj00lh7jww07cy3cil	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9yt501fi7jwwyi7x348q	cm3xuz9oj00lh7jww07cy3cil	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9yt601fk7jwwl9onyis1	cm3xuz9oj00lh7jww07cy3cil	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ys701em7jwwgk461eb3	cm3xuz9oj00lh7jww07cy3cil	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysa01eo7jwwcegwz94v	cm3xuz9oj00lh7jww07cy3cil	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysc01eq7jwwnrjufk2q	cm3xuz9oj00lh7jww07cy3cil	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9yse01es7jww887nz1xd	cm3xuz9oj00lh7jww07cy3cil	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysf01eu7jww1em13rqw	cm3xuz9oj00lh7jww07cy3cil	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysh01ew7jwwzkw4pfgr	cm3xuz9oj00lh7jww07cy3cil	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysk01ey7jwwwv2areoq	cm3xuz9oj00lh7jww07cy3cil	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysm01f07jwwrf6qawms	cm3xuz9oj00lh7jww07cy3cil	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9yso01f27jwwti3mfy9x	cm3xuz9oj00lh7jww07cy3cil	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9ysq01f47jww15guby9f	cm3xuz9oj00lh7jww07cy3cil	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayo502if7jwwzozvnc2x	2024-11-26 03:25:52.719	2024-11-26 03:26:40.133
cm3xw9yqk01d47jwwj41qd1yj	cm3xusu1p00l67jwwmm29up9j	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd7c005c11m2sf9p2sq8	2024-11-26 03:25:52.719	2024-11-26 08:52:47.832
cm3xw9yuz01h87jwwk7nznw5u	cm3xv4w6000m37jww5tkffps0	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yv101ha7jwwtqgv5og4	cm3xv4w6000m37jww5tkffps0	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yv301hc7jwws6uamicn	cm3xv4w6000m37jww5tkffps0	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yv601he7jwwc18lk9ab	cm3xv4w6000m37jww5tkffps0	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yv801hg7jwwjzjtcxep	cm3xv4w6000m37jww5tkffps0	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yva01hi7jww711849h4	cm3xv4w6000m37jww5tkffps0	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvc01hk7jwwj5zsh17j	cm3xv4w6000m37jww5tkffps0	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yve01hm7jwwftixtf6h	cm3xv4w6000m37jww5tkffps0	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvh01ho7jwwge04602r	cm3xv4w6000m37jww5tkffps0	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvj01hq7jwwpk1z8elz	cm3xv4w6000m37jww5tkffps0	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvl01hs7jwwa7ou4h64	cm3xv4w6000m37jww5tkffps0	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvm01hu7jwww52rx8sf	cm3xv4w6000m37jww5tkffps0	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvo01hw7jwwytnxz4tp	cm3xv4w6000m37jww5tkffps0	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvr01hy7jwwj8dti3r7	cm3xv4w6000m37jww5tkffps0	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvs01i07jwwuct7gbkl	cm3xv4w6000m37jww5tkffps0	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yvu01i27jwwhvc15ov5	cm3xv4w6000m37jww5tkffps0	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ywj01iq7jwwlaa4eb15	cm3xv4w6000m37jww5tkffps0	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9ywm01is7jwwkhharrkg	cm3xv4w6000m37jww5tkffps0	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9ywo01iu7jwwu4ldwoja	cm3xv4w6000m37jww5tkffps0	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9ywq01iw7jww0lc8ac5p	cm3xv4w6000m37jww5tkffps0	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9yws01iy7jww88o9gmlh	cm3xv4w6000m37jww5tkffps0	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9ywt01j07jwweda83ph0	cm3xv4w6000m37jww5tkffps0	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9yww01j27jwwwl90aret	cm3xv4w6000m37jww5tkffps0	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9ywy01j47jww01dmvzjd	cm3xv4w6000m37jww5tkffps0	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9yvv01i47jww73o4ombl	cm3xv4w6000m37jww5tkffps0	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yvx01i67jwwe0tm1cca	cm3xv4w6000m37jww5tkffps0	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yw001i87jwwzmn9kitf	cm3xv4w6000m37jww5tkffps0	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yw201ia7jwwlmwluvcd	cm3xv4w6000m37jww5tkffps0	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yw401ic7jwwv13cszin	cm3xv4w6000m37jww5tkffps0	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yw601ie7jwwkpatg8h6	cm3xv4w6000m37jww5tkffps0	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yw701ig7jww35um5kzm	cm3xv4w6000m37jww5tkffps0	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9ywa01ii7jwwybnljpc1	cm3xv4w6000m37jww5tkffps0	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9ywc01ik7jww7wse6giu	cm3xv4w6000m37jww5tkffps0	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9ywf01im7jwwfyi4dgy2	cm3xv4w6000m37jww5tkffps0	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yye01kg7jwwbd6zfl3i	cm3xv4w6000m37jww5tkffps0	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyg01ki7jwws7w77bb4	cm3xv4w6000m37jww5tkffps0	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyi01kk7jww944r39gc	cm3xv4w6000m37jww5tkffps0	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyl01km7jwws0niw6zq	cm3xv4w6000m37jww5tkffps0	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyn01ko7jwwnrohwcja	cm3xvd52v00n07jwwu9txe547	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyp01kq7jwwp4cl1gqd	cm3xvd52v00n07jwwu9txe547	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyr01ks7jww3c6j7oyy	cm3xvd52v00n07jwwu9txe547	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yys01ku7jwwgmswf771	cm3xvd52v00n07jwwu9txe547	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyu01kw7jww7vdc83ry	cm3xvd52v00n07jwwu9txe547	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyx01ky7jwwwtb7x6s5	cm3xvd52v00n07jwwu9txe547	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yyz01l07jwwjg9c2xns	cm3xvd52v00n07jwwu9txe547	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yz101l27jwwul25o2y9	cm3xvd52v00n07jwwu9txe547	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yz301l47jww8u7ty312	cm3xvd52v00n07jwwu9txe547	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yz401l67jwwphaeaslv	cm3xvd52v00n07jwwu9txe547	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yz701l87jwwdtjgrh7d	cm3xvd52v00n07jwwu9txe547	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yza01la7jwwsfoj013f	cm3xvd52v00n07jwwu9txe547	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yzc01lc7jwwnygmqlyl	cm3xvd52v00n07jwwu9txe547	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yze01le7jwwy5ur51hp	cm3xvd52v00n07jwwu9txe547	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yzg01lg7jwwkt6quyqk	cm3xvd52v00n07jwwu9txe547	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yzj01li7jwwhpdv5ktb	cm3xvd52v00n07jwwu9txe547	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yzl01lk7jww81wg2wx5	cm3xvd52v00n07jwwu9txe547	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yzm01lm7jwwee5fnuju	cm3xvd52v00n07jwwu9txe547	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9yxr01ju7jwwcrxqgc2w	cm3xv4w6000m37jww5tkffps0	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yxu01jw7jwwq4qcu77m	cm3xv4w6000m37jww5tkffps0	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yxv01jy7jwwltslhul4	cm3xv4w6000m37jww5tkffps0	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yxx01k07jwwroje9ma8	cm3xv4w6000m37jww5tkffps0	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yxz01k27jwwse58hvpj	cm3xv4w6000m37jww5tkffps0	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yy201k47jww3ahywrw3	cm3xv4w6000m37jww5tkffps0	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yy301k67jwwy0ss0af4	cm3xv4w6000m37jww5tkffps0	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yy501k87jwwc7h0he1e	cm3xv4w6000m37jww5tkffps0	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yy701ka7jwwx9y3cs4s	cm3xv4w6000m37jww5tkffps0	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yy901kc7jwwz5yyqluz	cm3xv4w6000m37jww5tkffps0	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6q004f11m2gviu7a94	2024-11-26 03:25:52.719	2024-11-26 08:52:47.81
cm3xw9yzo01lo7jwwy1u89s1i	cm3xvd52v00n07jwwu9txe547	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9yzq01lq7jww4gwwbbdf	cm3xvd52v00n07jwwu9txe547	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9yzt01ls7jww41jid9he	cm3xvd52v00n07jwwu9txe547	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z1o01ne7jwwk7mv990l	cm3xvd52v00n07jwwu9txe547	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z1q01ng7jww5pwzy8q5	cm3xvd52v00n07jwwu9txe547	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z1s01ni7jwwcs3ax3lg	cm3xvd52v00n07jwwu9txe547	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z1u01nk7jww04ilngwu	cm3xvd52v00n07jwwu9txe547	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z1w01nm7jwwajhginzi	cm3xvd52v00n07jwwu9txe547	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2a01no7jww7od8ww0u	cm3xvd52v00n07jwwu9txe547	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2c01nq7jww07mxz7ee	cm3xvd52v00n07jwwu9txe547	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4j001o11m2bg6yb9wl	2024-11-26 03:25:52.719	2024-11-26 08:52:47.731
cm3xw9z2n01o07jwwkj5k0n2n	cm3xvd52v00n07jwwu9txe547	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2o01o27jww6bdafhr5	cm3xvd52v00n07jwwu9txe547	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2q01o47jwwq8w3ppy3	cm3xvd52v00n07jwwu9txe547	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2s01o67jwwx9ju1y69	cm3xvd52v00n07jwwu9txe547	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2u01o87jwwl7kv4dne	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2v01oa7jwwqo29m1mc	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2x01oc7jwwlqbids71	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z2y01oe7jwwdafxxco8	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3001og7jwwu880nc8g	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3201oi7jww0fnn7zon	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3401ok7jwwvxqqo29t	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3801om7jwwjtk3dfey	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3a01oo7jwwnal5ss0g	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3c01oq7jwwk71vlvor	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3f01os7jwwapip9czr	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3h01ou7jwwb5slvec4	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3j01ow7jwwlliaa0wi	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3l01oy7jwwo29lx987	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3n01p07jww1i2dshif	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z0k01mg7jwwnedm6wci	cm3xvd52v00n07jwwu9txe547	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0m01mi7jwwsdv3d0im	cm3xvd52v00n07jwwu9txe547	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0o01mk7jwwdxu4mr11	cm3xvd52v00n07jwwu9txe547	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0s01mm7jwwsgvvdfn8	cm3xvd52v00n07jwwu9txe547	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0u01mo7jwwd4xv07zw	cm3xvd52v00n07jwwu9txe547	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0w01mq7jwwe68j18ow	cm3xvd52v00n07jwwu9txe547	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0y01ms7jwwftbi8bus	cm3xvd52v00n07jwwu9txe547	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z1001mu7jwwwj2ads72	cm3xvd52v00n07jwwu9txe547	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z3q01p27jwwlgccddgw	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3s01p47jwwq9bs9esl	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z3u01p67jww0dv3cm9n	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z5w01qy7jww6ffnyqoh	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z5y01r07jwwxe5066z9	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6101r27jwwz67a5b18	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6301r47jwwo08vowis	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6501r67jwwty9oeu8r	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6801r87jww1ehxynkw	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6b01ra7jwwxhi72upc	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6d01rc7jwwi6h0gwvk	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6f01re7jwwonvhlgd9	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6h01rg7jwwjjjidvia	cm3xv2tuq00ls7jwwsxzu6lcp	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4a001d11m2vuv9oo3i	2024-11-26 03:25:52.719	2024-11-26 08:52:47.722
cm3xw9z6m01rk7jwwdhin4dqv	cm3xv2tuq00ls7jwwsxzu6lcp	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z6o01rm7jww85krfde2	cm3xv2tuq00ls7jwwsxzu6lcp	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z4k01pu7jwwixck6awx	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4n01pw7jwwg70d1ems	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4q01py7jwwwk8zl0i2	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4s01q07jwwvv0s90j1	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4u01q27jww5pzu0hnx	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4w01q47jwwmww8bdpe	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z4z01q67jwwny8hkilb	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z5101q87jwwe8p9qwx6	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z3v01p87jwwjaa5j0po	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z3y01pa7jwwbybo89tq	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4201pc7jww1j0u4eh4	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4401pe7jww4cilgo6z	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4601pg7jwwmsdamxi2	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4701pi7jww7mfup7yk	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4901pk7jwws9rk28e5	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4c01pm7jww3k0h3ukw	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4e01po7jww1bs439b7	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z4g01pq7jww1agh9vzo	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z6q01ro7jww2st6clcc	cm3xv2tuq00ls7jwwsxzu6lcp	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z6s01rq7jww4a4j136e	cm3xv2tuq00ls7jwwsxzu6lcp	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z6v01rs7jwwte14683z	cm3xv6vyj00me7jww8fatnd46	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z6x01ru7jwwv0x888t5	cm3xv6vyj00me7jww8fatnd46	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z6y01rw7jww8tthqey5	cm3xv6vyj00me7jww8fatnd46	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7101ry7jwwh6aohwjf	cm3xv6vyj00me7jww8fatnd46	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7301s07jwwq3385dvg	cm3xv6vyj00me7jww8fatnd46	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7601s27jwwmsgkp02z	cm3xv6vyj00me7jww8fatnd46	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7801s47jww9bp5c02f	cm3xv6vyj00me7jww8fatnd46	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7a01s67jwwq42ppswg	cm3xv6vyj00me7jww8fatnd46	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7c01s87jww9fjaqqjn	cm3xv6vyj00me7jww8fatnd46	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7e01sa7jwwxojtci8b	cm3xv6vyj00me7jww8fatnd46	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7h01sc7jwwyk6m0y1m	cm3xv6vyj00me7jww8fatnd46	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7j01se7jwwqxi3d3g0	cm3xv6vyj00me7jww8fatnd46	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7l01sg7jwwbxhctoyr	cm3xv6vyj00me7jww8fatnd46	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7n01si7jww09sgl1p5	cm3xv6vyj00me7jww8fatnd46	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7p01sk7jwwkd65qy33	cm3xv6vyj00me7jww8fatnd46	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7t01sm7jwwzxxpnz9q	cm3xv6vyj00me7jww8fatnd46	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7w01so7jwwxg9h07hd	cm3xv6vyj00me7jww8fatnd46	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z7y01sq7jwwl1xqm2yv	cm3xv6vyj00me7jww8fatnd46	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9z8o01te7jww8qo8n85s	cm3xv6vyj00me7jww8fatnd46	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z8s01tg7jwwdy7vy5v1	cm3xv6vyj00me7jww8fatnd46	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z8u01ti7jww1v9ktyg2	cm3xv6vyj00me7jww8fatnd46	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z8w01tk7jwwb63nsn8d	cm3xv6vyj00me7jww8fatnd46	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z7z01ss7jwwmth2em1l	cm3xv6vyj00me7jww8fatnd46	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8101su7jwwjl0wkf7h	cm3xv6vyj00me7jww8fatnd46	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8401sw7jwwir0i55q0	cm3xv6vyj00me7jww8fatnd46	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8601sy7jwwz3kvj158	cm3xv6vyj00me7jww8fatnd46	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8801t07jwwtjyal0lw	cm3xv6vyj00me7jww8fatnd46	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8a01t27jwww058vuuu	cm3xv6vyj00me7jww8fatnd46	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8c01t47jww2wurb042	cm3xv6vyj00me7jww8fatnd46	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8f01t67jww46iww91x	cm3xv6vyj00me7jww8fatnd46	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8h01t87jwwqkbtaci7	cm3xv6vyj00me7jww8fatnd46	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9z8l01ta7jwwn3cln6lt	cm3xv6vyj00me7jww8fatnd46	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9za101ui7jwwwrerac6p	cm3xv6vyj00me7jww8fatnd46	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9za301uk7jwwgr3ade73	cm3xv6vyj00me7jww8fatnd46	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9za601um7jwwde9cn8mm	cm3xv6vyj00me7jww8fatnd46	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9za801uo7jwwekf2oqkd	cm3xv6vyj00me7jww8fatnd46	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zas01v47jwwo1k4alf9	cm3xv6vyj00me7jww8fatnd46	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zau01v67jww683z77o9	cm3xv6vyj00me7jww8fatnd46	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zav01v87jwwaz6kky5k	cm3xv6vyj00me7jww8fatnd46	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zay01va7jwwo23xri7m	cm3xv6vyj00me7jww8fatnd46	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zb101vc7jwwsu3435pl	cm3xvamu600mp7jwwmgb1kf5e	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zb301ve7jwwds0n4edr	cm3xvamu600mp7jwwmgb1kf5e	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zb501vg7jwwkr2thuls	cm3xvamu600mp7jwwmgb1kf5e	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zb701vi7jww3gs1a346	cm3xvamu600mp7jwwmgb1kf5e	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zb901vk7jwwj0p2xv47	cm3xvamu600mp7jwwmgb1kf5e	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbc01vm7jwwhxvurcpg	cm3xvamu600mp7jwwmgb1kf5e	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbe01vo7jwwi8q1xseq	cm3xvamu600mp7jwwmgb1kf5e	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbg01vq7jww3am3xrer	cm3xvamu600mp7jwwmgb1kf5e	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbi01vs7jww7k22qmv0	cm3xvamu600mp7jwwmgb1kf5e	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbk01vu7jwwtvylmnr4	cm3xvamu600mp7jwwmgb1kf5e	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbo01vw7jwwztyi6g2u	cm3xvamu600mp7jwwmgb1kf5e	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbr01vy7jwwsulxelew	cm3xvamu600mp7jwwmgb1kf5e	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbs01w07jww1smb6p2n	cm3xvamu600mp7jwwmgb1kf5e	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbu01w27jwwtg5wkysk	cm3xvamu600mp7jwwmgb1kf5e	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbw01w47jwwr9h1iaaf	cm3xvamu600mp7jwwmgb1kf5e	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zbz01w67jww458vq56f	cm3xvamu600mp7jwwmgb1kf5e	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zc101w87jwwx0hwaesr	cm3xvamu600mp7jwwmgb1kf5e	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zc301wa7jwwp7zjlj4i	cm3xvamu600mp7jwwmgb1kf5e	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zaa01uq7jww3kdn33kz	cm3xv6vyj00me7jww8fatnd46	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zae01us7jww6owdjxmj	cm3xv6vyj00me7jww8fatnd46	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zag01uu7jww3bs2p8zk	cm3xv6vyj00me7jww8fatnd46	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zai01uw7jwwruyf4qlc	cm3xv6vyj00me7jww8fatnd46	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zak01uy7jwwbwkp1mib	cm3xv6vyj00me7jww8fatnd46	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5g002w11m27ady5dhp	2024-11-26 03:25:52.719	2024-11-26 08:52:47.764
cm3xw9zc501wc7jwwi4bn2x1g	cm3xvamu600mp7jwwmgb1kf5e	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zc701we7jwwhhe59i8q	cm3xvamu600mp7jwwmgb1kf5e	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zca01wg7jwwrrdj39iy	cm3xvamu600mp7jwwmgb1kf5e	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zcc01wi7jwwudmtt4bz	cm3xvamu600mp7jwwmgb1kf5e	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9ze501y27jwwaqqdd6so	cm3xvamu600mp7jwwmgb1kf5e	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9ze701y47jww8h30v2ln	cm3xvamu600mp7jwwmgb1kf5e	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9ze901y67jwwi7rozry6	cm3xvamu600mp7jwwmgb1kf5e	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zeb01y87jwwyec1f094	cm3xvamu600mp7jwwmgb1kf5e	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zed01ya7jwwr38tyyxk	cm3xvamu600mp7jwwmgb1kf5e	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zef01yc7jwwtymzvwmf	cm3xvamu600mp7jwwmgb1kf5e	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zeh01ye7jwwa8zy77wk	cm3xvamu600mp7jwwmgb1kf5e	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zek01yg7jwwa263pfha	cm3xvamu600mp7jwwmgb1kf5e	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zel01yi7jww7qhifsy7	cm3xvamu600mp7jwwmgb1kf5e	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zen01yk7jwwkz5lt3zw	cm3xvamu600mp7jwwmgb1kf5e	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd4r001z11m2x8o8se3g	2024-11-26 03:25:52.719	2024-11-26 08:52:47.739
cm3xw9zeu01yo7jwwfjpqkij8	cm3xvamu600mp7jwwmgb1kf5e	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zew01yq7jwwyp6xiug7	cm3xvamu600mp7jwwmgb1kf5e	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zey01ys7jww7r04fulz	cm3xvamu600mp7jwwmgb1kf5e	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zf001yu7jwwyz9xdvn5	cm3xvamu600mp7jwwmgb1kf5e	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zf301yw7jwwlfjvctwy	cm3xvi9qr00nm7jwwmi7v4fru	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zf501yy7jww6ed7fgax	cm3xvi9qr00nm7jwwmi7v4fru	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zf701z07jwwf0zt0d8i	cm3xvi9qr00nm7jwwmi7v4fru	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zf901z27jww8tyrvstb	cm3xvi9qr00nm7jwwmi7v4fru	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfb01z47jwwj6sfm55e	cm3xvi9qr00nm7jwwmi7v4fru	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfe01z67jww3jb4h2on	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfg01z87jwwwet3k116	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfi01za7jww49oaafcm	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfl01zc7jww7x53icfw	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfn01ze7jwwzt7rv5gp	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfq01zg7jww52lmqtha	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zcu01wy7jww3qxdxyx6	cm3xvamu600mp7jwwmgb1kf5e	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zcx01x07jww8l2jq7ts	cm3xvamu600mp7jwwmgb1kf5e	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zcz01x27jwwysn0izug	cm3xvamu600mp7jwwmgb1kf5e	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zd101x47jwwnhl6mxvd	cm3xvamu600mp7jwwmgb1kf5e	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zd301x67jww2h1okk1r	cm3xvamu600mp7jwwmgb1kf5e	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zd501x87jwwfb4b3bs8	cm3xvamu600mp7jwwmgb1kf5e	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zd901xa7jwwif3ct49f	cm3xvamu600mp7jwwmgb1kf5e	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zdb01xc7jww7t6povuw	cm3xvamu600mp7jwwmgb1kf5e	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zcs01ww7jwwj4lxdwz1	cm3xvamu600mp7jwwmgb1kf5e	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zft01zi7jww489ynx82	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfv01zk7jww185hczyd	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfx01zm7jwwlv5ogqz7	cm3xvi9qr00nm7jwwmi7v4fru	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zfz01zo7jww9flua8nz	cm3xvi9qr00nm7jwwmi7v4fru	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zg201zq7jwwnd7zdj5f	cm3xvi9qr00nm7jwwmi7v4fru	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zg401zs7jwwc6noai9x	cm3xvi9qr00nm7jwwmi7v4fru	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zg601zu7jwwexudp0lq	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zib021m7jww8223cp2v	cm3xvi9qr00nm7jwwmi7v4fru	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zid021o7jwwsasrni6o	cm3xvi9qr00nm7jwwmi7v4fru	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zif021q7jwww96txflh	cm3xvi9qr00nm7jwwmi7v4fru	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zig021s7jwwswwrexhx	cm3xvi9qr00nm7jwwmi7v4fru	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zii021u7jwwof6ccf8k	cm3xvi9qr00nm7jwwmi7v4fru	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zim021w7jwwkzxyju6o	cm3xvi9qr00nm7jwwmi7v4fru	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zip021y7jwwypmsspp4	cm3xvi9qr00nm7jwwmi7v4fru	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zir02207jwwlxspzoxs	cm3xvi9qr00nm7jwwmi7v4fru	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zit02227jwwf383bcfk	cm3xvi9qr00nm7jwwmi7v4fru	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zgx020i7jww4q7uqapg	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zh1020k7jwwyel2tkdx	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zh3020m7jww03gadamt	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zh6020o7jwwioj9r9is	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zh7020q7jww6nbhaik8	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zh9020s7jwwziqg82za	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zhc020u7jwwxfxmmdk4	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zhe020w7jwwr19a4xre	cm3xvi9qr00nm7jwwmi7v4fru	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zg801zw7jww5zirgtd7	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zga01zy7jwwl9tszygj	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zge02007jww8yvpozkz	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgh02027jwwmv1dpnnf	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgj02047jwwfh3bhoe1	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgk02067jwwcd885sra	cm3xvi9qr00nm7jwwmi7v4fru	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgm02087jwwobu9r7e8	cm3xvi9qr00nm7jwwmi7v4fru	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgq020a7jwwjy0pc3p7	cm3xvi9qr00nm7jwwmi7v4fru	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgs020c7jwws1lv5dgm	cm3xvi9qr00nm7jwwmi7v4fru	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zgu020e7jwwrjfcbdkc	cm3xvi9qr00nm7jwwmi7v4fru	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9ziv02247jwwc93598im	cm3xvi9qr00nm7jwwmi7v4fru	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9ziy02267jww6y7japcb	cm3xvi9qr00nm7jwwmi7v4fru	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zj002287jwwgdz8c84y	cm3xvi9qr00nm7jwwmi7v4fru	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zj2022a7jww9znvm93p	cm3xvi9qr00nm7jwwmi7v4fru	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zj4022c7jww8olgykfq	cm3xvi9qr00nm7jwwmi7v4fru	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zj6022e7jww43o0hfr6	cm3xvi9qr00nm7jwwmi7v4fru	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zj9022g7jww530vgu48	cm3xvft2k00nb7jwwzijna876	clropuwwy00gk98xysca8iu4e	2024-09-02 00:00:00	2024-09-02 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjb022i7jww1juueemc	cm3xvft2k00nb7jwwzijna876	clropuwx100gn98xy4en4vxy8	2024-09-03 00:00:00	2024-09-03 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjd022k7jww2ki137vl	cm3xvft2k00nb7jwwzijna876	clropuwx300gq98xymn6lhwua	2024-09-04 00:00:00	2024-09-04 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjf022m7jwwlvhblra4	cm3xvft2k00nb7jwwzijna876	clropuwx600gt98xytsidgujh	2024-09-05 00:00:00	2024-09-05 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zji022o7jwweemjuci8	cm3xvft2k00nb7jwwzijna876	clropuwx800gw98xyj3trdkwj	2024-09-06 00:00:00	2024-09-06 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjl022q7jwwje91mbek	cm3xvft2k00nb7jwwzijna876	clropuwxe00h198xy0vybxvg1	2024-09-09 00:00:00	2024-09-09 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjn022s7jwwbzpdw579	cm3xvft2k00nb7jwwzijna876	clropuwxg00h498xyh6euu8go	2024-09-10 00:00:00	2024-09-10 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjp022u7jww2a5yrxc1	cm3xvft2k00nb7jwwzijna876	clropuwxi00h798xy6tr7ngy7	2024-09-11 00:00:00	2024-09-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjr022w7jww2atwwsn2	cm3xvft2k00nb7jwwzijna876	clropuwxk00ha98xy3s55ciqq	2024-09-12 00:00:00	2024-09-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjt022y7jwwqk66s3di	cm3xvft2k00nb7jwwzijna876	clropuwxm00hd98xyjz8mcdrb	2024-09-13 00:00:00	2024-09-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjx02307jww3wxsy9zr	cm3xvft2k00nb7jwwzijna876	clropuwxs00hi98xyw3q230c5	2024-09-16 00:00:00	2024-09-16 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zjz02327jww2p7m3ezy	cm3xvft2k00nb7jwwzijna876	clropuwxu00hl98xyt7kblkqt	2024-09-17 00:00:00	2024-09-17 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zk102347jww6gcv45k6	cm3xvft2k00nb7jwwzijna876	clropuwxw00ho98xye40w4r22	2024-09-18 00:00:00	2024-09-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zk302367jww402p4vds	cm3xvft2k00nb7jwwzijna876	clropuwxy00hr98xys115e2ev	2024-09-19 00:00:00	2024-09-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zk502387jwwwah5qcet	cm3xvft2k00nb7jwwzijna876	clropuwy000hu98xy5o2nt5d2	2024-09-20 00:00:00	2024-09-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zk8023a7jwwo3oy9lwe	cm3xvft2k00nb7jwwzijna876	clropuwy600hz98xydi9nu3kw	2024-09-23 00:00:00	2024-09-23 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zkb023c7jwwm4yvb40j	cm3xvft2k00nb7jwwzijna876	clropuwy800i298xyufxdfa1k	2024-09-24 00:00:00	2024-09-24 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zkd023e7jwwm02hezl6	cm3xvft2k00nb7jwwzijna876	clropuwyb00i598xyfbu9lasv	2024-09-25 00:00:00	2024-09-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zl402427jww4p47lgb3	cm3xvft2k00nb7jwwzijna876	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zkf023g7jww5mzsctsg	cm3xvft2k00nb7jwwzijna876	clropuwyd00i898xy8b73bbma	2024-09-26 00:00:00	2024-09-26 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkh023i7jww1ohu7e8s	cm3xvft2k00nb7jwwzijna876	clropuwyf00ib98xywbvmlp0k	2024-09-27 00:00:00	2024-09-27 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkk023k7jwwx9stm4yg	cm3xvft2k00nb7jwwzijna876	clropuwyl00ig98xyeb1ihmk0	2024-09-30 00:00:00	2024-09-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkm023m7jwwfh8dwjo3	cm3xvft2k00nb7jwwzijna876	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zko023o7jwwsldh5rz3	cm3xvft2k00nb7jwwzijna876	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkr023q7jww7dmeb7g8	cm3xvft2k00nb7jwwzijna876	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkt023s7jwwzmqu2zjq	cm3xvft2k00nb7jwwzijna876	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkv023u7jwwluqjxxa8	cm3xvft2k00nb7jwwzijna876	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkx023w7jwwvi26n0s0	cm3xvft2k00nb7jwwzijna876	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zkz023y7jww8s9kbthf	cm3xvft2k00nb7jwwzijna876	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xw9zmf02567jwwji1woa8p	cm3xvft2k00nb7jwwzijna876	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmh02587jwwwoztg0p9	cm3xvft2k00nb7jwwzijna876	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmk025a7jwwl1ulyq13	cm3xvft2k00nb7jwwzijna876	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmm025c7jwwq61tpmho	cm3xvft2k00nb7jwwzijna876	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmo025e7jwwtnbomxrg	cm3xvft2k00nb7jwwzijna876	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmr025g7jwwk116or76	cm3xvft2k00nb7jwwzijna876	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmu025i7jww3896dngu	cm3xvft2k00nb7jwwzijna876	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmw025k7jwwjj0lz076	cm3xvft2k00nb7jwwzijna876	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zmy025m7jwwpgb0jkgw	cm3xvft2k00nb7jwwzijna876	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zn0025o7jww0aapbcd7	cm3xvft2k00nb7jwwzijna876	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zn3025q7jwwtp8lgu5p	cm3xvft2k00nb7jwwzijna876	clropux1x00m898xyeb65o59h	2024-11-25 00:00:00	2024-11-25 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zn6025s7jwwqgo9pn4i	cm3xvft2k00nb7jwwzijna876	clropux2000mb98xy8yfmk7p7	2024-11-26 00:00:00	2024-11-26 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zn8025u7jww715vauyj	cm3xvft2k00nb7jwwzijna876	clropux2200me98xy2x6i1n67	2024-11-27 00:00:00	2024-11-27 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9zna025w7jww2q938vcb	cm3xvft2k00nb7jwwzijna876	clropux2400mh98xyvoal1skx	2024-11-28 00:00:00	2024-11-28 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9znc025y7jww2n7djdca	cm3xvft2k00nb7jwwzijna876	clropux2700mk98xya8xcphpc	2024-11-29 00:00:00	2024-11-29 10:00:00	f	f	f	f	f	t	0	0	0	\N	2024-11-26 03:25:52.719	2024-11-26 03:25:52.719
cm3xw9y6300ug7jwwgl4prvd6	cm3xu8bx700jn7jwwlfh8k68g	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6600ui7jwwtkwpnkbc	cm3xu8bx700jn7jwwlfh8k68g	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6800uk7jwwota3ipp5	cm3xu8bx700jn7jwwlfh8k68g	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6a00um7jwwaiu80t2i	cm3xu8bx700jn7jwwlfh8k68g	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6e00uo7jwwrjblintq	cm3xu8bx700jn7jwwlfh8k68g	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6g00uq7jww4lfkderm	cm3xu8bx700jn7jwwlfh8k68g	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6j00us7jww6plszqiu	cm3xu8bx700jn7jwwlfh8k68g	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6k00uu7jwwqku1s3r8	cm3xu8bx700jn7jwwlfh8k68g	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9y6m00uw7jwwl9sj7pui	cm3xu8bx700jn7jwwlfh8k68g	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9jl02637jwwknfdmyoi	2024-11-26 03:25:52.719	2024-11-26 03:26:07.569
cm3xw9yae00y07jww9zgmbdvh	cm3xuj38h00kk7jwwnwywtik2	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yaf00y27jwwii8svd66	cm3xuj38h00kk7jwwnwywtik2	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yai00y47jwwt2w8ewa4	cm3xuj38h00kk7jwwnwywtik2	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yak00y67jwwslv51ry9	cm3xuj38h00kk7jwwnwywtik2	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yan00y87jwwed3ujxmt	cm3xuj38h00kk7jwwnwywtik2	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yap00ya7jwwf3r0p8jn	cm3xuj38h00kk7jwwnwywtik2	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yaq00yc7jwwopg377xj	cm3xuj38h00kk7jwwnwywtik2	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yas00ye7jwwhazaqicm	cm3xuj38h00kk7jwwnwywtik2	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9yau00yg7jwwojprsijr	cm3xuj38h00kk7jwwnwywtik2	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9k9026e7jww0sk7vhn3	2024-11-26 03:25:52.719	2024-11-26 03:26:07.593
cm3xw9ye1011k7jwwgy746emk	cm3xud7bl00jy7jww9qzfi51c	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9ye3011m7jww8lpqp123	cm3xud7bl00jy7jww9qzfi51c	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9ye5011o7jww343o1f8y	cm3xud7bl00jy7jww9qzfi51c	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9ye6011q7jww43ogh05t	cm3xud7bl00jy7jww9qzfi51c	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yea011s7jwwggl2h3w7	cm3xud7bl00jy7jww9qzfi51c	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yeb011u7jwwxa2d8oa1	cm3xud7bl00jy7jww9qzfi51c	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yed011w7jwwrxf2uzk9	cm3xud7bl00jy7jww9qzfi51c	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yef011y7jww9761t269	cm3xud7bl00jy7jww9qzfi51c	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yeh01207jww5smmqa7v	cm3xud7bl00jy7jww9qzfi51c	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9kq026p7jwwkcs9mpla	2024-11-26 03:25:52.719	2024-11-26 03:26:07.61
cm3xw9yhr01547jwwjwsviqge	cm3xuoj8d00kv7jwwop9hwrrk	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yhs01567jww5x5sedbj	cm3xuoj8d00kv7jwwop9hwrrk	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yhu01587jwwivacve5g	cm3xuoj8d00kv7jwwop9hwrrk	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yhw015a7jwwx36eb9ft	cm3xuoj8d00kv7jwwop9hwrrk	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yi0015c7jwwhlnkndjp	cm3xuoj8d00kv7jwwop9hwrrk	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yi2015e7jwwexr3pe48	cm3xuoj8d00kv7jwwop9hwrrk	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yi4015g7jwwwcvakckw	cm3xuoj8d00kv7jwwop9hwrrk	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yi6015i7jwwgv05wmz0	cm3xuoj8d00kv7jwwop9hwrrk	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9yi8015k7jww5ftx2nbp	cm3xuoj8d00kv7jwwop9hwrrk	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9l602707jwwlcjj1u0n	2024-11-26 03:25:52.719	2024-11-26 03:26:07.626
cm3xw9ylg018o7jwwv88q6brj	cm3xufw6p00k97jww8n9qq7fq	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9yli018q7jwwp2e2hls1	cm3xufw6p00k97jww8n9qq7fq	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ylj018s7jwwfifmx388	cm3xufw6p00k97jww8n9qq7fq	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ylk018u7jwwvwt8xubj	cm3xufw6p00k97jww8n9qq7fq	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9yln018w7jwwocviatve	cm3xufw6p00k97jww8n9qq7fq	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ylp018y7jww43v2o743	cm3xufw6p00k97jww8n9qq7fq	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9yls01907jwwndredxme	cm3xufw6p00k97jww8n9qq7fq	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ylu01927jwwf18rbti0	cm3xufw6p00k97jww8n9qq7fq	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ylv01947jww6je17in7	cm3xufw6p00k97jww8n9qq7fq	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ll027b7jwwys6rkhnn	2024-11-26 03:25:52.719	2024-11-26 03:26:07.641
cm3xw9ypk01c87jww3pimqlf7	cm3xusu1p00l67jwwmm29up9j	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypn01ca7jwwl0d857l2	cm3xusu1p00l67jwwmm29up9j	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypp01cc7jww3h2isho9	cm3xusu1p00l67jwwmm29up9j	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypr01ce7jwwt8ru04r0	cm3xusu1p00l67jwwmm29up9j	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypu01cg7jww4wigh2dz	cm3xusu1p00l67jwwmm29up9j	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypw01ci7jwwrzh4cuee	cm3xusu1p00l67jwwmm29up9j	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9ypy01ck7jwwpp40np46	cm3xusu1p00l67jwwmm29up9j	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9yq101cm7jwwn8jikpv0	cm3xusu1p00l67jwwmm29up9j	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9yq201co7jwwguob2j1k	cm3xusu1p00l67jwwmm29up9j	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9m0027m7jwwehfe9j6r	2024-11-26 03:25:52.719	2024-11-26 03:26:07.656
cm3xw9yte01fs7jwwyvxu4o7g	cm3xuz9oj00lh7jww07cy3cil	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytg01fu7jww7y3bkj8c	cm3xuz9oj00lh7jww07cy3cil	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9yti01fw7jww4wd8ozf4	cm3xuz9oj00lh7jww07cy3cil	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytl01fy7jwwkdz1cgdl	cm3xuz9oj00lh7jww07cy3cil	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytp01g07jww3avak2vx	cm3xuz9oj00lh7jww07cy3cil	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytr01g27jwwkw3vluo9	cm3xuz9oj00lh7jww07cy3cil	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9yts01g47jww8j1r69s3	cm3xuz9oj00lh7jww07cy3cil	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytu01g67jww8oypa5gd	cm3xuz9oj00lh7jww07cy3cil	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9ytw01g87jwwmz771trv	cm3xuz9oj00lh7jww07cy3cil	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mg027x7jwwsaqbcwhu	2024-11-26 03:25:52.719	2024-11-26 03:26:07.672
cm3xw9yx601jc7jwwcbzktx4i	cm3xv4w6000m37jww5tkffps0	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yx801je7jwwtgs107vo	cm3xv4w6000m37jww5tkffps0	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxa01jg7jwwpv18dqbn	cm3xv4w6000m37jww5tkffps0	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxc01ji7jwwpcl7t6t5	cm3xv4w6000m37jww5tkffps0	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxg01jk7jwwpvj1zt5i	cm3xv4w6000m37jww5tkffps0	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxi01jm7jwwojjsl4pc	cm3xv4w6000m37jww5tkffps0	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxk01jo7jww99l7sgsn	cm3xv4w6000m37jww5tkffps0	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxm01jq7jwwtst1da2t	cm3xv4w6000m37jww5tkffps0	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9yxo01js7jwwf332wui1	cm3xv4w6000m37jww5tkffps0	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9mw02887jwwcsqhtuz1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.688
cm3xw9z1301mw7jww3lfvsz6t	cm3xvd52v00n07jwwu9txe547	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1501my7jwwi24vfkhg	cm3xvd52v00n07jwwu9txe547	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1701n07jwwit7lbx8z	cm3xvd52v00n07jwwu9txe547	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1801n27jwwduchpux9	cm3xvd52v00n07jwwu9txe547	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1c01n47jwwpssqpo7c	cm3xvd52v00n07jwwu9txe547	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1e01n67jwwepm0cx2t	cm3xvd52v00n07jwwu9txe547	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1g01n87jwwuw6gba2s	cm3xvd52v00n07jwwu9txe547	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1j01na7jww4hhiebr3	cm3xvd52v00n07jwwu9txe547	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z1l01nc7jwws379mo2u	cm3xvd52v00n07jwwu9txe547	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nc028j7jwwbd86me2q	2024-11-26 03:25:52.719	2024-11-26 03:26:07.704
cm3xw9z5a01qg7jwwu5v8a257	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5c01qi7jww8g7cdb5k	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5e01qk7jwwmq5fa7tk	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5h01qm7jwwdaclvnhw	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5l01qo7jww3tp7dwaq	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5n01qq7jwwk8sc0x8d	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5p01qs7jww88933php	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5r01qu7jwwi2n8zawv	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z5t01qw7jwwugusbd0z	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9nr028u7jwwxa6l9m9k	2024-11-26 03:25:52.719	2024-11-26 03:26:07.719
cm3xw9z9g01u07jwwo08yjcis	cm3xv6vyj00me7jww8fatnd46	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9i01u27jwwjbltbbkc	cm3xv6vyj00me7jww8fatnd46	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9k01u47jwwati19x8t	cm3xv6vyj00me7jww8fatnd46	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9m01u67jwwvzai6scm	cm3xv6vyj00me7jww8fatnd46	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9q01u87jwwoxoqag65	cm3xv6vyj00me7jww8fatnd46	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9s01ua7jwwb3054hns	cm3xv6vyj00me7jww8fatnd46	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9u01uc7jwwck3w8cib	cm3xv6vyj00me7jww8fatnd46	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9w01ue7jwwdxq5oklz	cm3xv6vyj00me7jww8fatnd46	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9z9y01ug7jwwpeasfkvl	cm3xv6vyj00me7jww8fatnd46	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9o602957jwwcoyadat1	2024-11-26 03:25:52.719	2024-11-26 03:26:07.734
cm3xw9zdk01xk7jwwdnu292xk	cm3xvamu600mp7jwwmgb1kf5e	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdm01xm7jwwnt8dsvaz	cm3xvamu600mp7jwwmgb1kf5e	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdo01xo7jwwagn1x6s8	cm3xvamu600mp7jwwmgb1kf5e	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdq01xq7jww5fg7xmtj	cm3xvamu600mp7jwwmgb1kf5e	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdu01xs7jwwfeocusz4	cm3xvamu600mp7jwwmgb1kf5e	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdw01xu7jwwidl361cm	cm3xvamu600mp7jwwmgb1kf5e	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zdy01xw7jww8r1aplj7	cm3xvamu600mp7jwwmgb1kf5e	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9ze101xy7jwwtrb5sbnz	cm3xvamu600mp7jwwmgb1kf5e	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9ze201y07jwwfv3hmamw	cm3xvamu600mp7jwwmgb1kf5e	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9oj029g7jwwqe3rfx8t	2024-11-26 03:25:52.719	2024-11-26 03:26:07.747
cm3xw9zho02147jwwep4pioez	cm3xvi9qr00nm7jwwmi7v4fru	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zhq02167jwwrg0tgf7j	cm3xvi9qr00nm7jwwmi7v4fru	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zhs02187jwwobprntsm	cm3xvi9qr00nm7jwwmi7v4fru	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zhu021a7jww367hwm20	cm3xvi9qr00nm7jwwmi7v4fru	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zhz021c7jww3sh38vb7	cm3xvi9qr00nm7jwwmi7v4fru	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zi2021e7jwwn8gbd04d	cm3xvi9qr00nm7jwwmi7v4fru	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zi4021g7jwwau3zwmww	cm3xvi9qr00nm7jwwmi7v4fru	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zi5021i7jww3ui4n1i9	cm3xvi9qr00nm7jwwmi7v4fru	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zi8021k7jwwzhjc7g3t	cm3xvi9qr00nm7jwwmi7v4fru	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9ow029r7jww575jxxcf	2024-11-26 03:25:52.719	2024-11-26 03:26:07.76
cm3xw9zlu024o7jww6m9brevx	cm3xvft2k00nb7jwwzijna876	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zlw024q7jwwxejpe9pz	cm3xvft2k00nb7jwwzijna876	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zly024s7jwwilobz410	cm3xvft2k00nb7jwwzijna876	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zm0024u7jwwgxzb3vbg	cm3xvft2k00nb7jwwzijna876	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zm4024w7jwww1d14xgv	cm3xvft2k00nb7jwwzijna876	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zm6024y7jww01k7smws	cm3xvft2k00nb7jwwzijna876	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zm802507jwwdh6p33j9	cm3xvft2k00nb7jwwzijna876	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zma02527jwwk1nmq29x	cm3xvft2k00nb7jwwzijna876	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xw9zmc02547jwwvl9n7hcu	cm3xvft2k00nb7jwwzijna876	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9pb02a27jwwztuh38v6	2024-11-26 03:25:52.719	2024-11-26 03:26:07.775
cm3xpfpnz00a17jwww5ra213g	cm3sd6n7y000h98xyfpmb6any	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo100a37jww58mvtsyk	cm3sd6n7y000h98xyfpmb6any	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo200a57jwwxou7iz1p	cm3sd6n7y000h98xyfpmb6any	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo400a77jww3ehjxls6	cm3sd6n7y000h98xyfpmb6any	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo700a97jww1mbr6jdz	cm3sd6n7y000h98xyfpmb6any	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo800ab7jww6jjyacjw	cm3sd6n7y000h98xyfpmb6any	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpo900ad7jwwnfp080qd	cm3sd6n7y000h98xyfpmb6any	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpob00af7jwwdfuwa89p	cm3sd6n7y000h98xyfpmb6any	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfpod00ah7jwwkj5zm0lc	cm3sd6n7y000h98xyfpmb6any	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9q002ad7jwwjrmcujv1	2024-11-26 00:14:24.378	2024-11-26 03:26:07.8
cm3xpfppw00c57jwwrz6le9v0	cm3sd5sob000698xytgsayvvu	clropux0b00kc98xybpk97rjm	2024-10-28 00:00:00	2024-10-28 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfppy00c77jwwa71tmhei	cm3sd5sob000698xytgsayvvu	clropux0d00kf98xykk7eqz8t	2024-10-29 00:00:00	2024-10-29 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfppz00c97jwwiqlrj4dg	cm3sd5sob000698xytgsayvvu	clropux0f00ki98xy2lu41to0	2024-10-30 00:00:00	2024-10-30 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpq100cb7jwwg65fxqak	cm3sd5sob000698xytgsayvvu	clropux0i00kl98xyzczvsjui	2024-10-31 00:00:00	2024-10-31 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpq400cd7jwwsv4d9350	cm3sd5sob000698xytgsayvvu	clropux0p00kt98xyq03iryq0	2024-11-04 00:00:00	2024-11-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpq500cf7jwwqstyjk8h	cm3sd5sob000698xytgsayvvu	clropux0r00kw98xyy9z77uyz	2024-11-05 00:00:00	2024-11-05 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpq700ch7jwwfj2mgxmq	cm3sd5sob000698xytgsayvvu	clropux0t00kz98xy5jvyicvz	2024-11-06 00:00:00	2024-11-06 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpq800cj7jwwo3eotzrj	cm3sd5sob000698xytgsayvvu	clropux0v00l298xyxn6qle7m	2024-11-07 00:00:00	2024-11-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xpfpqa00cl7jwwfxys8bpk	cm3sd5sob000698xytgsayvvu	clropux0x00l598xy5hh0pj1u	2024-11-08 00:00:00	2024-11-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwa9qj02ao7jwwjyy17l4h	2024-11-26 00:14:24.378	2024-11-26 03:26:07.819
cm3xw9y5v00u87jww58b4v15o	cm3xu8bx700jn7jwwlfh8k68g	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5w00ua7jww8khji7p8	cm3xu8bx700jn7jwwlfh8k68g	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y5z00uc7jwwx2srts9a	cm3xu8bx700jn7jwwlfh8k68g	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9y6000ue7jwwyp9g1q8t	cm3xu8bx700jn7jwwlfh8k68g	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq2i02bc7jwwmkuczqiz	2024-11-26 03:25:52.719	2024-11-26 03:26:28.986
cm3xw9ya800xu7jwwidxcbptz	cm3xuj38h00kk7jwwnwywtik2	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9ya900xw7jwwhe1ob529	cm3xuj38h00kk7jwwnwywtik2	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9yab00xy7jwwm621vlmx	cm3xuj38h00kk7jwwnwywtik2	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3102bn7jww28zg5z8b	2024-11-26 03:25:52.719	2024-11-26 03:26:29.005
cm3xw9yde010y7jwwvnkaw21e	cm3xud7bl00jy7jww9qzfi51c	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydh01107jwwghqe1mty	cm3xud7bl00jy7jww9qzfi51c	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydi01127jwwo0n765nk	cm3xud7bl00jy7jww9qzfi51c	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydl01147jww6gw1hgrs	cm3xud7bl00jy7jww9qzfi51c	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydm01167jwws7x4wbgf	cm3xud7bl00jy7jww9qzfi51c	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydo01187jww6qhn2uwa	cm3xud7bl00jy7jww9qzfi51c	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydr011a7jwwm6xwnceu	cm3xud7bl00jy7jww9qzfi51c	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydt011c7jwwtwq506el	cm3xud7bl00jy7jww9qzfi51c	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydu011e7jwwbyd1ext2	cm3xud7bl00jy7jww9qzfi51c	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydx011g7jwws72pjhp4	cm3xud7bl00jy7jww9qzfi51c	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9ydy011i7jww9fpphn0c	cm3xud7bl00jy7jww9qzfi51c	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3g02by7jwwlztlj0j0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.02
cm3xw9yhj014y7jwwj8o5yl8i	cm3xuoj8d00kv7jwwop9hwrrk	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yhl01507jwww9bp3d67	cm3xuoj8d00kv7jwwop9hwrrk	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yho01527jwwm05gheo1	cm3xuoj8d00kv7jwwop9hwrrk	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq3u02c97jww0pj05nhy	2024-11-26 03:25:52.719	2024-11-26 03:26:29.034
cm3xw9yla018i7jwwznre90vh	cm3xufw6p00k97jww8n9qq7fq	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9ylb018k7jwwv8fu25c8	cm3xufw6p00k97jww8n9qq7fq	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9yld018m7jww7yuj38tm	cm3xufw6p00k97jww8n9qq7fq	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4902ck7jwwohz45zls	2024-11-26 03:25:52.719	2024-11-26 03:26:29.047
cm3xw9you01bm7jww50xkg5c1	cm3xusu1p00l67jwwmm29up9j	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yoy01bo7jww15czeihd	cm3xusu1p00l67jwwmm29up9j	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yp001bq7jww8xnvnxzt	cm3xusu1p00l67jwwmm29up9j	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yp201bs7jwwxwkhw1vf	cm3xusu1p00l67jwwmm29up9j	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yp401bu7jww0f2ebdvi	cm3xusu1p00l67jwwmm29up9j	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yp501bw7jwwg45cp0om	cm3xusu1p00l67jwwmm29up9j	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9ypa01by7jwwsdzcs24w	cm3xusu1p00l67jwwmm29up9j	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq4m02cv7jww6vruxive	2024-11-26 03:25:52.719	2024-11-26 03:26:29.062
cm3xw9yt801fm7jwwly6l3zzo	cm3xuz9oj00lh7jww07cy3cil	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9yta01fo7jwwcrrluwp7	cm3xuz9oj00lh7jww07cy3cil	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ytb01fq7jwwdkaygv35	cm3xuz9oj00lh7jww07cy3cil	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5102d67jwweh96wcqx	2024-11-26 03:25:52.719	2024-11-26 03:26:29.077
cm3xw9ywz01j67jww16qv7ggr	cm3xv4w6000m37jww5tkffps0	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9yx101j87jwwfmjvvwc2	cm3xv4w6000m37jww5tkffps0	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9yx401ja7jww49vtoeqe	cm3xv4w6000m37jww5tkffps0	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5g02dh7jww74ftsvb0	2024-11-26 03:25:52.719	2024-11-26 03:26:29.092
cm3xw9z0d01ma7jwwz1m0nmhg	cm3xvd52v00n07jwwu9txe547	clropuwzb00j998xyoe12k035	2024-10-11 00:00:00	2024-10-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0g01mc7jww74xjfa6k	cm3xvd52v00n07jwwu9txe547	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z0i01me7jwwf136eeks	cm3xvd52v00n07jwwu9txe547	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq5w02ds7jww8w8x9pob	2024-11-26 03:25:52.719	2024-11-26 03:26:29.108
cm3xw9z5301qa7jwwkxj8xfg2	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z5501qc7jwwhv0pz7dt	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z5701qe7jwwyxm64ozj	cm3xv2tuq00ls7jwwsxzu6lcp	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq7o02e37jwwsv1wlecm	2024-11-26 03:25:52.719	2024-11-26 03:26:29.171
cm3xw9z8y01tm7jwwusr3je2w	cm3xv6vyj00me7jww8fatnd46	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9001to7jwww7dcr0u2	cm3xv6vyj00me7jww8fatnd46	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9301tq7jwwq7vvqlzi	cm3xv6vyj00me7jww8fatnd46	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9501ts7jwwf2nj8f2h	cm3xv6vyj00me7jww8fatnd46	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9701tu7jwwln5uqftq	cm3xv6vyj00me7jww8fatnd46	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9901tw7jwwvl6nfkrk	cm3xv6vyj00me7jww8fatnd46	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9z9b01ty7jwwmk8s9lst	cm3xv6vyj00me7jww8fatnd46	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq8i02ee7jww6n3757v8	2024-11-26 03:25:52.719	2024-11-26 03:26:29.201
cm3xw9zdd01xe7jww1w9n7bux	cm3xvamu600mp7jwwmgb1kf5e	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zdf01xg7jwwpmf62cbe	cm3xvamu600mp7jwwmgb1kf5e	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zdh01xi7jww3w7mbydj	cm3xvamu600mp7jwwmgb1kf5e	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9b02ep7jwwvjfajti7	2024-11-26 03:25:52.719	2024-11-26 03:26:29.23
cm3xw9zhg020y7jww5ywzkbr3	cm3xvi9qr00nm7jwwmi7v4fru	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zhi02107jwwlv4rxilo	cm3xvi9qr00nm7jwwmi7v4fru	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zhl02127jwwyxh7iqob	cm3xvi9qr00nm7jwwmi7v4fru	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaq9p02f07jwwfbt77mwi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.245
cm3xw9zl602447jwwm9o0uwhz	cm3xvft2k00nb7jwwzijna876	clropuwzg00je98xyobsrxzbi	2024-10-14 00:00:00	2024-10-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zl802467jwwkes1cwkq	cm3xvft2k00nb7jwwzijna876	clropuwzj00jh98xydyqk9xh4	2024-10-15 00:00:00	2024-10-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zla02487jwwaqjgyz48	cm3xvft2k00nb7jwwzijna876	clropuwzl00jk98xymo5w25jc	2024-10-16 00:00:00	2024-10-16 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zlc024a7jwwxph2mxbw	cm3xvft2k00nb7jwwzijna876	clropuwzn00jn98xyzdnmyoc1	2024-10-17 00:00:00	2024-10-17 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zle024c7jww08qjqnh6	cm3xvft2k00nb7jwwzijna876	clropuwzq00jq98xy76aam9kw	2024-10-18 00:00:00	2024-10-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zlh024e7jww76efclqc	cm3xvft2k00nb7jwwzijna876	clropuwzv00jv98xylx6g95v3	2024-10-21 00:00:00	2024-10-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zlj024g7jwwqpzkmmze	cm3xvft2k00nb7jwwzijna876	clropuwzx00jy98xy31r2life	2024-10-22 00:00:00	2024-10-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zll024i7jwwro752ecd	cm3xvft2k00nb7jwwzijna876	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zln024k7jwwpbt1tjfg	cm3xvft2k00nb7jwwzijna876	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xw9zlp024m7jww1fnife1r	cm3xvft2k00nb7jwwzijna876	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqa302fb7jwwp4noh3gi	2024-11-26 03:25:52.719	2024-11-26 03:26:29.259
cm3xpfpnu009v7jwwmtfa94zh	cm3sd6n7y000h98xyfpmb6any	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnv009x7jwwjnudebj2	cm3sd6n7y000h98xyfpmb6any	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfpnx009z7jwwkht37ch0	cm3sd6n7y000h98xyfpmb6any	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqav02fm7jwwl3fdip74	2024-11-26 00:14:24.378	2024-11-26 03:26:29.287
cm3xpfppq00bz7jwwm20t30oz	cm3sd5sob000698xytgsayvvu	clropux0000k198xyf63u7fqt	2024-10-23 00:00:00	2024-10-23 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfpps00c17jwwvn5qhe5q	cm3sd5sob000698xytgsayvvu	clropux0200k498xy9q5u95i8	2024-10-24 00:00:00	2024-10-24 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xpfppt00c37jwwr5tynog7	cm3sd5sob000698xytgsayvvu	clropux0600k798xy9ha07sf1	2024-10-25 00:00:00	2024-10-25 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaqbc02fx7jwwpm1qptq6	2024-11-26 00:14:24.378	2024-11-26 03:26:29.304
cm3xw9y9q00xc7jww3bg7lwd7	cm3xuj38h00kk7jwwnwywtik2	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaym502gw7jww7v5zypqk	2024-11-26 03:25:52.719	2024-11-26 03:26:40.061
cm3xw9ydc010w7jwwol9ih81f	cm3xud7bl00jy7jww9qzfi51c	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaymj02h77jwwqniwklfq	2024-11-26 03:25:52.719	2024-11-26 03:26:40.075
cm3xw9yks01807jwwk9c7wrra	cm3xufw6p00k97jww8n9qq7fq	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaync02ht7jwws7vif268	2024-11-26 03:25:52.719	2024-11-26 03:26:40.103
cm3xw9yok01bc7jww62rrfg5p	cm3xusu1p00l67jwwmm29up9j	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yom01be7jwwfpylel15	cm3xusu1p00l67jwwmm29up9j	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yoo01bg7jww62tty8gh	cm3xusu1p00l67jwwmm29up9j	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yoq01bi7jwww0n6fkl6	cm3xusu1p00l67jwwmm29up9j	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9yos01bk7jww9fj2c6km	cm3xusu1p00l67jwwmm29up9j	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaynq02i47jwwullojyxh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.118
cm3xw9ywh01io7jwwic6nneop	cm3xv4w6000m37jww5tkffps0	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoj02iq7jwwj4cy3u1m	2024-11-26 03:25:52.719	2024-11-26 03:26:40.147
cm3xw9yzv01lu7jwwzcy1z7pm	cm3xvd52v00n07jwwu9txe547	clropuwyn00ij98xyo0xuon61	2024-10-01 00:00:00	2024-10-01 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9yzx01lw7jwwqb3hcker	cm3xvd52v00n07jwwu9txe547	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0001ly7jwwwoew3ycw	cm3xvd52v00n07jwwu9txe547	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0201m07jwwgfwait3s	cm3xvd52v00n07jwwu9txe547	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0501m27jwwib7eu7wl	cm3xvd52v00n07jwwu9txe547	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0701m47jwwew0et9in	cm3xvd52v00n07jwwu9txe547	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0901m67jwwbnpcr68f	cm3xvd52v00n07jwwu9txe547	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z0b01m87jwwmaaq1s3p	cm3xvd52v00n07jwwu9txe547	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayoy02j17jwwwxnm3ybd	2024-11-26 03:25:52.719	2024-11-26 03:26:40.162
cm3xw9z4i01ps7jww56zfsugt	cm3xv2tuq00ls7jwwsxzu6lcp	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaype02jc7jww7028frj5	2024-11-26 03:25:52.719	2024-11-26 03:26:40.178
cm3xw9z8n01tc7jww62pvqtsn	cm3xv6vyj00me7jww8fatnd46	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayps02jn7jwwcwq1aqkh	2024-11-26 03:25:52.719	2024-11-26 03:26:40.192
cm3xw9zce01wk7jwwvikdr8a4	cm3xvamu600mp7jwwmgb1kf5e	clropuwyq00im98xykwz24tf1	2024-10-02 00:00:00	2024-10-02 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zcg01wm7jwwj7suflkt	cm3xvamu600mp7jwwmgb1kf5e	clropuwys00ip98xyimr4hj4v	2024-10-03 00:00:00	2024-10-03 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zcj01wo7jww719i726t	cm3xvamu600mp7jwwmgb1kf5e	clropuwyv00is98xyd5rufzjk	2024-10-04 00:00:00	2024-10-04 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zcm01wq7jwwmdxiz9ex	cm3xvamu600mp7jwwmgb1kf5e	clropuwz100ix98xyxpo7lwfl	2024-10-07 00:00:00	2024-10-07 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zco01ws7jwwe4ehm6sj	cm3xvamu600mp7jwwmgb1kf5e	clropuwz400j098xygtkei6wg	2024-10-08 00:00:00	2024-10-08 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zcq01wu7jwwxjsa1igx	cm3xvamu600mp7jwwmgb1kf5e	clropuwz700j398xy23pvyv85	2024-10-09 00:00:00	2024-10-09 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqa02jy7jww4nd86l91	2024-11-26 03:25:52.719	2024-11-26 03:26:40.21
cm3xw9zgw020g7jww3jugd65l	cm3xvi9qr00nm7jwwmi7v4fru	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayqq02k97jwwyn8ae2eg	2024-11-26 03:25:52.719	2024-11-26 03:26:40.225
cm3xw9zl202407jww5wnu9irf	cm3xvft2k00nb7jwwzijna876	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwayr402kk7jwwbq6q8l7i	2024-11-26 03:25:52.719	2024-11-26 03:26:40.24
cm3xpfpr500dl7jwwuze4yox7	emman	clropuwz900j698xyrrsfpjj0	2024-10-10 00:00:00	2024-10-10 10:00:00	f	f	f	f	f	t	0	0	0	cm3xwaysh02ln7jwwbif5piag	2024-11-26 00:14:24.378	2024-11-26 03:26:40.289
cm3xpfpqc00cn7jwwlajsp8yc	cm3sd5sob000698xytgsayvvu	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqe00cp7jww66rzeqw5	cm3sd5sob000698xytgsayvvu	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqf00cr7jww6murwxba	cm3sd5sob000698xytgsayvvu	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqh00ct7jwwjrena8n2	cm3sd5sob000698xytgsayvvu	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqi00cv7jwwthur880t	cm3sd5sob000698xytgsayvvu	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpql00cx7jwwrsiljob9	cm3sd5sob000698xytgsayvvu	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqm00cz7jwwdilqrcix	cm3sd5sob000698xytgsayvvu	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqo00d17jwwnd4aqize	cm3sd5sob000698xytgsayvvu	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqp00d37jww1pknk7qb	cm3sd5sob000698xytgsayvvu	clropux1p00m098xyaz6rw480	2024-11-21 00:00:00	2024-11-21 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfpqr00d57jwwdfmgenuc	cm3sd5sob000698xytgsayvvu	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd5y003i11m236bps05u	2024-11-26 00:14:24.378	2024-11-26 08:52:47.782
cm3xpfps700er7jwwguzzw1gu	emman	clropux1300la98xyltx84oyo	2024-11-11 00:00:00	2024-11-11 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfps800et7jwws2xostwx	emman	clropux1500ld98xyulc1qclh	2024-11-12 00:00:00	2024-11-12 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsa00ev7jwweulz8osz	emman	clropux1700lg98xyu0srgkzu	2024-11-13 00:00:00	2024-11-13 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsc00ex7jwwjagdg1xu	emman	clropux1900lj98xyeuld28xu	2024-11-14 00:00:00	2024-11-14 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsd00ez7jwwex8fhom3	emman	clropux1b00lm98xy8ylikutk	2024-11-15 00:00:00	2024-11-15 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsf00f17jwwk4nr18h2	emman	clropux1h00lr98xypqf58wrh	2024-11-18 00:00:00	2024-11-18 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsh00f37jwwbgpvfjfb	emman	clropux1k00lu98xy3e1azdw9	2024-11-19 00:00:00	2024-11-19 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpsi00f57jwwfc02oppe	emman	clropux1n00lx98xy1i7exfqy	2024-11-20 00:00:00	2024-11-20 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd67003t11m22m4lcfr7	2024-11-26 00:14:24.378	2024-11-26 08:52:47.79
cm3xpfpox00b17jww5mgwel14	cm3sd6n7y000h98xyfpmb6any	clropux1r00m398xy6fxll2mn	2024-11-22 00:00:00	2024-11-22 10:00:00	f	f	f	f	f	t	0	0	0	cm3y7yd6j004411m2fi06w93m	2024-11-26 00:14:24.378	2024-11-26 08:52:47.803
\.


--
-- Data for Name: TwoFactorConfirmation; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."TwoFactorConfirmation" ("id", "userId") FROM stdin;
\.


--
-- Data for Name: TwoFactorToken; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."TwoFactorToken" ("id", "email", "token", "expires") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."User" ("id", "firstName", "middleName", "lastName", "gender", "dateOfBirth", "jobTitle", "email", "createdAt", "updatedAt", "lastLogin", "vacationDays", "incentiveDays", "emailVerified", "image", "password", "role", "isTwoFactorEnabled", "twoFactorConfirmationId", "isArchived") FROM stdin;
cm3xu8bx700jn7jwwlfh8k68g	Julian 	El	Vasquez	MALE	2024-11-13 00:00:00	Singer	jlee@gmail.com	2024-11-26 02:28:38.105	2024-11-26 03:12:11.361	2024-11-26 02:28:38.105	5	5	2024-11-26 02:28:50.615	\N	$2b$10$0ftIzInrrZgRYkqV7qyEqun.d5QInnmSe4llw3s3muW.47.7W9Bu.	ADMIN	f	\N	f
cm3xuj38h00kk7jwwnwywtik2	Jousheen Ly	Castanares	Salac	MALE	2003-12-23 00:00:00	Gambler	jlcsalac@gmail.com	2024-11-26 02:37:00.064	2024-11-26 03:18:21.17	2024-11-26 02:37:00.064	5	5	2024-11-26 02:37:11.359	\N	$2b$10$/t1Y.um5yAABU9T0x4rp9.9hLDc/UUJslBEnNuUkx8E0O/UIBnYeC	ADMIN	f	\N	f
cm3xud7bl00jy7jww9qzfi51c	Francis Paolo 	Vito	Echavez	MALE	2003-04-14 00:00:00	Marketing Engineer	fpvde@gmail.com	2024-11-26 02:32:25.425	2024-11-26 03:15:07.623	2024-11-26 02:32:25.425	5	5	2024-11-26 02:32:37.269	\N	$2b$10$BQNpyGXxtWNrOQrbnZMGqu3mIUF/UxaLJt68I0Cv1m1NS7sfaecxy	ADMIN	f	\N	f
cm3xuoj8d00kv7jwwop9hwrrk	Bon	Rafael	Reparial	MALE	2003-09-01 00:00:00	Architecht	breparial@gmail.com	2024-11-26 02:41:14.077	2024-11-26 03:47:01.533	2024-11-26 03:47:01.532	5	5	2024-11-26 02:41:21.987	\N	$2b$10$SyMKADRMnZei.iD5Qb9hw.a/0Wpp.sAGhAKHkulPZsWounfo4A5Uy	ADMIN	f	\N	f
cm3xufw6p00k97jww8n9qq7fq	Bryan Neil	Tupas	Floresta	MALE	2003-01-21 00:00:00	Industrial Engineer	bntfloresta@gmail.com	2024-11-26 02:34:30.961	2024-11-26 03:44:15.488	2024-11-26 03:44:15.487	5	5	2024-11-26 02:34:44.02	\N	$2b$10$JVGM.SoW1gufjDewJAFqvuka9gvv8Ee9iwH1OLqyrO3UCIg2NhbM.	USER	f	\N	f
cm3xusu1p00l67jwwmm29up9j	Kyle	Parreno	Caballes	MALE	2003-11-10 00:00:00	Chef	kpcaballes@gmail.com	2024-11-26 02:44:34.717	2024-11-26 09:05:13.757	2024-11-26 02:44:34.717	5	5	2024-11-26 02:44:45.787	\N	$2b$10$qtwrAEhdOzz45Nse8Zga2O3ze6equxY9Uumy8/W8oHf/vGXMhWvyi	USER	f	\N	f
cm3xv4w6000m37jww5tkffps0	Marlo	Jose	Magdangal	MALE	2003-02-08 00:00:00	Baccarat Demon	mjdmagdangal@gmail.com	2024-11-26 02:53:57.336	2024-11-26 02:54:07.828	2024-11-26 02:53:57.336	5	5	2024-11-26 02:54:07.827	\N	$2b$10$wriQz4/kjiYtp9Mdwg5gnOMDHll5vHllpMtMJbhx/Kk9l505aaK7C	USER	f	\N	f
cm3xvd52v00n07jwwu9txe547	Richard Jame	Dela Pena	Deano	MALE	2003-09-13 00:00:00	Marketing Engineer	rjddeano@gmail.com	2024-11-26 03:00:22.135	2024-11-26 03:00:28.975	2024-11-26 03:00:22.135	5	5	2024-11-26 03:00:28.974	\N	$2b$10$uLTWKpUq6gGlCVj9Y1LT4OdaWNKk2B4E3imFM5KsV5eXbXSmcD2h2	USER	f	\N	f
cm3xuz9oj00lh7jww07cy3cil	Dutch	Van	der Linde	MALE	2001-03-18 00:00:00	Planner	DVderlinde@gmail.com	2024-11-26 02:49:34.914	2024-11-26 09:03:55.503	2024-11-26 02:49:34.914	5	5	2024-11-26 02:49:51.279	\N	$2b$10$wvwlvQKVRh/Gugcez5o0BekkS6v5xH7A7.jDD8P/Zjr4JJeO8ZZJC	ADMIN	f	\N	f
cm3xv6vyj00me7jww8fatnd46	Reanne Kevin	Ramos	Angcos	MALE	2003-06-10 00:00:00	HR	rkrangcos@gmail.com	2024-11-26 02:55:30.378	2024-11-26 03:14:46.58	2024-11-26 02:55:30.378	5	5	2024-11-26 02:55:38.358	\N	$2b$10$n6g3OiqLWFBt69vu1ohNSezaQfbt4McWHJlQkOyDAMmfky5Z3fqHO	ADMIN	f	\N	f
cm3xv2tuq00ls7jwwsxzu6lcp	Kentavious	Caldwell	Pope	MALE	2002-12-11 00:00:00	HR	kcpope@gmail.com	2024-11-26 02:52:21.026	2024-11-26 08:59:19.265	2024-11-26 02:52:21.026	5	5	2024-11-26 02:52:29.261	\N	$2b$10$tQ8g6zHdcsYfrUZGsJ8Z1eBto93ZAZDTKydsAN03HPyOXwJ2Jrj.K	ADMIN	f	\N	f
cm3xvamu600mp7jwwmgb1kf5e	Ivan	James	Lo	MALE	2002-11-20 00:00:00	Software Engineer	ijalo@gmail.com	2024-11-26 02:58:25.182	2024-11-26 03:12:55.105	2024-11-26 02:58:25.182	5	5	2024-11-26 02:58:30.011	\N	$2b$10$QwdP5lNdpVFPZTpCOf03recD/9VlOmEb1A7i402CDdsbtBK3Z7mxi	ADMIN	f	\N	f
cm3xvi9qr00nm7jwwmi7v4fru	Kyle	Gabriel	Tabla	MALE	2003-07-18 00:00:00	Marketing Engineer	kgdtabla@gmail.com	2024-11-26 03:04:21.458	2024-11-26 03:17:33.073	2024-11-26 03:04:21.458	5	5	2024-11-26 03:04:29.186	\N	$2b$10$ti/YHxaTnh42sA2xvwCldOTK0swcbK8ymkpniR0mp5NOTNdS3Mlom	ADMIN	f	\N	f
cm3xvft2k00nb7jwwzijna876	Miguel	Corleone 	Co	MALE	2003-10-01 00:00:00	Green	mgco@gmail.com	2024-11-26 03:02:26.54	2024-11-26 03:17:40.938	2024-11-26 03:02:26.54	5	5	2024-11-26 03:02:34.366	\N	$2b$10$AxpZRbiPvY2CB8JxUXNDB.DBr22kWMiGIqczMDULzUrhv0cp.9XDe	ADMIN	f	\N	f
cm3y7pz20000d11m2522rpsoa	John	Doe	Smith	MALE	2000-11-11 00:00:00	Software Engineer	john.doe@gmail.com	2024-11-26 08:46:16.247	2024-11-26 08:46:16.247	2024-11-26 08:46:16.247	5	5	\N	\N	$2b$10$u3GRIWbaARUJwjLMefF8aOWI7DNhrDzm8LGcjcHfdDbKVlOepxlbK	USER	f	\N	f
cm3sd6n7y000h98xyfpmb6any	Shan	Nuel	Tranquilan	MALE	2024-11-20 00:00:00	Gambler	snstranquilan@gmail.com	2024-11-22 06:32:35.086	2024-11-25 10:14:01.983	2024-11-25 10:14:01.981	5	5	2024-11-22 06:40:33.943	\N	$2b$10$4b4MGSn73nbeRWW8YC2B8u/Tf0xEfp2vtFWVyKgEjb9s6RqJhdnE6	SUPERADMIN	f	\N	f
cm3sd5sob000698xytgsayvvu	Ellyanna Nicole	Louh	Du	FEMALE	2024-12-05 00:00:00	First Lady	enldu@gmail.com	2024-11-22 06:31:55.498	2024-11-25 10:17:37.324	2024-11-25 10:17:37.323	5	5	2024-11-22 06:32:00.848	\N	$2b$10$EztqT3x9P/I/vZzw5gtm8u4bEsG2KYtP.dy8v7rwA.w8UyQi2LsBK	SUPERADMIN	f	\N	f
emman	Emmanuel	Diaz	Aguado	MALE	2003-05-13 16:00:00	CEO	eaguado@addu.edu.ph	2024-11-21 16:07:12.129	2024-12-06 10:45:30.785	2024-12-06 10:45:30.783	5	5	2024-11-21 16:00:00	https://yff2xv1mgpf5hkyr.public?.blob.vercel-storage.com/profile-pictures/emman-shs-30C9T4RErtOMQDthEI9ekUat7wUQuh.JPG	$2a$10$tnYDL2WFoKBWRDzEf19mM.ivPqoHyWLW08e13Vxh/R6S3z2QswNSS	SUPERADMIN	f	\N	f
\.


--
-- Data for Name: UserSalary; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."UserSalary" ("id", "userId", "basicSalary", "grossSalary", "createdAt", "updatedAt") FROM stdin;
cm3xv2tuv00lw7jwwk1l16riv	cm3xv2tuq00ls7jwwsxzu6lcp	25000	31000	2024-11-26 02:52:21.026	2024-11-26 02:52:21.026
cm3xvamu900mt7jwwy1yv83wg	cm3xvamu600mp7jwwmgb1kf5e	80000	86000	2024-11-26 02:58:25.182	2024-11-26 02:58:25.182
cm3xuoj8f00kz7jwwtmytptzy	cm3xuoj8d00kv7jwwop9hwrrk	30000	35000	2024-11-26 02:41:14.077	2024-11-26 03:14:17.012
cm3xvd52x00n47jwwelptqf9r	cm3xvd52v00n07jwwu9txe547	30000	35000	2024-11-26 03:00:22.135	2024-11-26 03:14:27.174
cm3xvi9qu00nq7jwwlv3xjckz	cm3xvi9qr00nm7jwwmi7v4fru	30000	35000	2024-11-26 03:04:21.458	2024-11-26 03:17:33.094
cm3xvft2n00nf7jww4ytkjjua	cm3xvft2k00nb7jwwzijna876	15000	20000	2024-11-26 03:02:26.54	2024-11-26 03:17:40.956
cm3sd6n82000l98xyp3a74jso	cm3sd6n7y000h98xyfpmb6any	5000	16000	2024-11-22 06:32:35.086	2024-11-26 04:10:23.96
cm3sd5sog000a98xy82jysly0	cm3sd5sob000698xytgsayvvu	5000	16000	2024-11-22 06:31:55.498	2024-11-26 04:10:23.96
cm3xufw6t00kd7jwwxd4vbjiy	cm3xufw6p00k97jww8n9qq7fq	25000	36000	2024-11-26 02:34:30.961	2024-11-26 04:10:23.96
cm3xu8bxf00jr7jwwah63okr6	cm3xu8bx700jn7jwwlfh8k68g	5000	16000	2024-11-26 02:28:38.105	2024-11-26 04:10:23.96
cm3xv4w6300m77jww2g2zswzp	cm3xv4w6000m37jww5tkffps0	50000	60000	2024-11-26 02:53:57.336	2024-11-26 04:10:23.96
cm3xv6vyl00mi7jwwnqb5jdlu	cm3xv6vyj00me7jww8fatnd46	25000	36000	2024-11-26 02:55:30.378	2024-11-26 04:13:05.35
cm3xud7bo00k27jwwh2l1nl9r	cm3xud7bl00jy7jww9qzfi51c	20000	31000	2024-11-26 02:32:25.425	2024-11-26 05:29:37.474
cm3rie8o900007ibqqq7li318	emman	6000	17000	2024-11-21 16:10:41.385	2024-11-26 08:00:54.011
cm3y7pz26000h11m2k8n3yppz	cm3y7pz20000d11m2522rpsoa	20000	25000	2024-11-26 08:46:16.247	2024-11-26 08:46:16.247
cm3xusu1r00la7jwwgspx81sz	cm3xusu1p00l67jwwmm29up9j	20000	31000	2024-11-26 02:44:34.717	2024-11-26 08:54:49.689
cm3xuz9oo00ll7jwwpeq3ior1	cm3xuz9oj00lh7jww07cy3cil	35000	46000	2024-11-26 02:49:34.914	2024-11-26 08:54:49.689
cm3xuj38j00ko7jwwub0mh1qx	cm3xuj38h00kk7jwwnwywtik2	50000	61000	2024-11-26 02:37:00.064	2024-11-26 08:57:30.324
\.


--
-- Data for Name: VerificationToken; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."VerificationToken" ("id", "email", "token", "expires") FROM stdin;
cm3y7pz2d000k11m2ra416qak	john.doe@gmail.com	3a1668c8-09bc-433f-9973-879d1feb77dd	2024-11-26 09:46:16.259
\.


--
-- Data for Name: WorkingDay; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."WorkingDay" ("id", "date", "password", "monthId", "isRequired", "createdAt", "updatedAt") FROM stdin;
clropuwgn001g98xyaz6stp4u	2024-01-21 16:00:00	c58276	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwgy001j98xys5pspi1m	2024-01-22 16:00:00	755c09	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwh1001m98xydmf2yibj	2024-01-23 16:00:00	b3283d	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwh5001p98xyaqxxkdun	2024-01-24 16:00:00	b6ece3	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwh8001s98xyzulzpchg	2024-01-25 16:00:00	827bf5	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhe001x98xyl10lcrb1	2024-01-28 16:00:00	3847e9	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhg002098xykao1n38g	2024-01-29 16:00:00	7fc884	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhl002398xy72gsdc6e	2024-01-30 16:00:00	d21dab	clropuwg8001e98xy3qyr8y2d	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhn002698xy6ijqlkid	2024-01-31 16:00:00	90c2cc	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhq002998xyj4uxaswu	2024-02-01 16:00:00	b45cd8	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhw002e98xyppdb8xp4	2024-02-04 16:00:00	16bb6c	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhz002h98xyha693ug5	2024-02-05 16:00:00	aac247	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwi3002k98xy4ybq1bjb	2024-02-06 16:00:00	59d6e7	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwi5002n98xydzwax2gc	2024-02-07 16:00:00	4ee000	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwi8002q98xy3qj3xwqt	2024-02-08 16:00:00	ffc382	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwie002v98xy1kwpmeqk	2024-02-11 16:00:00	73a55f	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwih002y98xykqff00im	2024-02-12 16:00:00	4ebdbf	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwij003198xyr0asw6pb	2024-02-13 16:00:00	e70a68	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwim003498xyc188sgnm	2024-02-14 16:00:00	df0204	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwio003798xyndiqvyqj	2024-02-15 16:00:00	647215	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwiu003c98xyd99dw9ne	2024-02-18 16:00:00	f07694	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwix003f98xywgw5czda	2024-02-19 16:00:00	d891e7	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwiz003i98xy1xkvudrr	2024-02-20 16:00:00	499486	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjg003l98xy1ydlm86v	2024-02-21 16:00:00	ca0d11	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjj003o98xym9a7u619	2024-02-22 16:00:00	6e26d5	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjp003t98xyty3rwd9q	2024-02-25 16:00:00	8e55e3	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjs003w98xy8z1j2hq0	2024-02-26 16:00:00	6a6c54	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjv003z98xyo7t65lr3	2024-02-27 16:00:00	1a1001	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwjz004298xychy1cx72	2024-02-28 16:00:00	ce49a5	clropuwhm002498xys9ajiscx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwk3004598xysc2jkr1v	2024-02-29 16:00:00	79a419	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwka004a98xyzqhk0kgj	2024-03-03 16:00:00	0d45a3	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkc004d98xy7sz1sdaw	2024-03-04 16:00:00	c2200b	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkf004g98xyxlj4uyjq	2024-03-05 16:00:00	87a236	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkj004j98xymeq9wg28	2024-03-06 16:00:00	3a9699	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkl004m98xynvq9wmom	2024-03-07 16:00:00	8bc726	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkr004r98xysdt8cio5	2024-03-10 16:00:00	677437	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkt004u98xyzb1xtgw3	2024-03-11 16:00:00	cf1815	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkw004x98xygcefgqzt	2024-03-12 16:00:00	606e92	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwkz005098xyta01p34d	2024-03-13 16:00:00	b8ff26	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwl2005398xy8ag26wrd	2024-03-14 16:00:00	6b09bc	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwl8005898xybnqzyhgq	2024-03-17 16:00:00	2921d3	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwlb005b98xykpmdjczi	2024-03-18 16:00:00	2d1a63	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwld005e98xy9w3x08yu	2024-03-19 16:00:00	e44c4f	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwlg005h98xyuw5pix69	2024-03-20 16:00:00	522441	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwlk005k98xytfgbraza	2024-03-21 16:00:00	ccdc79	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwlr005p98xyb5biilxd	2024-03-24 16:00:00	39af9d	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwlw005s98xyt9n9dbkj	2024-03-25 16:00:00	31a989	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwly005v98xy8qkd2c4r	2024-03-26 16:00:00	32a72c	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwm0005y98xyty3gbwse	2024-03-27 16:00:00	4efb50	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwm4006198xy0p4ahy15	2024-03-28 16:00:00	c98aa2	clropuwk2004398xy2ee5dr5u	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwmb006698xyob33molt	2024-03-31 16:00:00	8a3cab	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwmd006998xyx2pefx7j	2024-04-01 16:00:00	305c67	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwmf006c98xy6i4lzxot	2024-04-02 16:00:00	508125	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwmi006f98xy2z96o3f6	2024-04-03 16:00:00	fb0ce1	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwml006i98xyeblqes4g	2024-04-04 16:00:00	e5adb1	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwms006n98xy3um66zke	2024-04-07 16:00:00	6f94b6	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwmx006t98xypwxpdx5c	2024-04-09 16:00:00	bdca7b	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwn0006w98xytdujkref	2024-04-10 16:00:00	d5ce2b	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwn3006z98xynye7uv7e	2024-04-11 16:00:00	4e64ec	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwna007498xyk6ghf9vc	2024-04-14 16:00:00	7b1aa0	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwnc007798xy5sy75teg	2024-04-15 16:00:00	083c4a	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwnf007a98xyqujsw6pf	2024-04-16 16:00:00	09887f	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwni007d98xyr04u28td	2024-04-17 16:00:00	be8a4e	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwnl007g98xyp3vpjnpx	2024-04-18 16:00:00	425047	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwns007l98xyfe7s83i5	2024-04-21 16:00:00	59fff5	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwnu007o98xyh0nvuiq4	2024-04-22 16:00:00	5063e0	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwnx007r98xypkrl1f05	2024-04-23 16:00:00	7197d6	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwo0007u98xyseidtgv4	2024-04-24 16:00:00	6ad7d7	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwo2007x98xygp0uzk15	2024-04-25 16:00:00	1a15b5	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwo9008298xyo1rd6776	2024-04-28 16:00:00	55dce0	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwoc008598xyz9rab6c5	2024-04-29 16:00:00	007fce	clropuwm9006498xyco1dezvd	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwoh008b98xyvr26bt0r	2024-05-01 16:00:00	4c1b6c	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwoj008e98xyaoxsm0g4	2024-05-02 16:00:00	a51bb7	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwoq008j98xy9m1x641u	2024-05-05 16:00:00	ca0683	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwot008m98xyy8z7q3l4	2024-05-06 16:00:00	db6437	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwov008p98xytvvxv5pb	2024-05-07 16:00:00	c7072d	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwox008s98xya6l7ath1	2024-05-08 16:00:00	bbc11a	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwp1008v98xyklq4k1bm	2024-05-09 16:00:00	6752f4	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwp8009098xyyixdvfe1	2024-05-12 16:00:00	31a8bd	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpa009398xyjf1p2cba	2024-05-13 16:00:00	504c99	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpc009698xyj2h088wf	2024-05-14 16:00:00	c1a862	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpf009998xyoe23mlmh	2024-05-15 16:00:00	bf2634	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwph009c98xybyxbz0qm	2024-05-16 16:00:00	caee30	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpn009h98xy1bghzuiz	2024-05-19 16:00:00	d01b2b	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpp009k98xy11evrs1b	2024-05-20 16:00:00	83fdaa	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpr009n98xyce5wzm91	2024-05-21 16:00:00	aa7599	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpu009q98xyge2rir0x	2024-05-22 16:00:00	beac67	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwpx009t98xy1h82pqtf	2024-05-23 16:00:00	a4224e	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwq3009y98xyk4la6zpi	2024-05-26 16:00:00	bcc398	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwq700a198xysrk36iod	2024-05-27 16:00:00	e49215	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwq900a498xyyiwr9jc3	2024-05-28 16:00:00	ffc01f	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqd00a798xyqf2wetn4	2024-05-29 16:00:00	65a2e5	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqg00aa98xyqq70gfvf	2024-05-30 16:00:00	109880	clropuwod008698xygyfjf40g	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqm00af98xyl371nbzg	2024-06-02 16:00:00	3d1bcc	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqp00ai98xy066tpkvp	2024-06-03 16:00:00	c76e06	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqt00al98xyikhqt0p0	2024-06-04 16:00:00	35ccd8	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqx00ao98xyk7lzmzrj	2024-06-05 16:00:00	ce2756	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwr000ar98xyyciblnkp	2024-06-06 16:00:00	9b8e28	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwr500aw98xya6guv9ck	2024-06-09 16:00:00	389373	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwr900az98xy40eh53u6	2024-06-10 16:00:00	fcde9e	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwre00b598xys2p1h35e	2024-06-12 16:00:00	3db193	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwrh00b898xyvs7y0c50	2024-06-13 16:00:00	1eed3c	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwrm00bd98xyy5r7jg60	2024-06-16 16:00:00	5aeeec	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwrq00bg98xy4cb2i74k	2024-06-17 16:00:00	6104d4	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwrt00bj98xyssei5qyx	2024-06-18 16:00:00	3fb1bb	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwrw00bm98xyi058kl4t	2024-06-19 16:00:00	fcb526	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwry00bp98xyjb5why63	2024-06-20 16:00:00	dce417	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuws400bu98xyuq9fe9kx	2024-06-23 16:00:00	7fac8d	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuws700bx98xyeg4vroll	2024-06-24 16:00:00	297aa3	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsc00c098xy4vqxfb3m	2024-06-25 16:00:00	97a75c	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsf00c398xymv1izw8k	2024-06-26 16:00:00	3be4f9	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsh00c698xyvhzoy6ri	2024-06-27 16:00:00	f046d5	clropuwqh00ab98xyntle801c	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwso00cb98xyl3bpozem	2024-06-30 16:00:00	84e440	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsr00ce98xyifj7yo49	2024-07-01 16:00:00	ae8f48	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsu00ch98xyfx4kh3gw	2024-07-02 16:00:00	917ef1	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsw00ck98xyq3qyb200	2024-07-03 16:00:00	745bdd	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsy00cn98xykszfh6qz	2024-07-04 16:00:00	e12fe0	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwt300cs98xycanjfxby	2024-07-07 16:00:00	aa29c6	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwt500cv98xyc3o57t4c	2024-07-08 16:00:00	440d5c	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwt800cy98xyr5yt7jcu	2024-07-09 16:00:00	148007	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtb00d198xyha8n0xxw	2024-07-10 16:00:00	053a3f	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtd00d498xyug1qdlsa	2024-07-11 16:00:00	d112b8	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtj00d998xyzgqgw5zs	2024-07-14 16:00:00	646537	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtl00dc98xywm0fy1be	2024-07-15 16:00:00	648477	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtq00df98xy3ocrwz05	2024-07-16 16:00:00	27c614	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtt00di98xyphl5w9rl	2024-07-17 16:00:00	8abb70	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwtv00dl98xyigmphgua	2024-07-18 16:00:00	03076b	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwu000dq98xy8bskjx6g	2024-07-21 16:00:00	e4319c	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwu200dt98xyknxj49hz	2024-07-22 16:00:00	c686ca	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwu400dw98xyg1b1jlxn	2024-07-23 16:00:00	189abe	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwu700dz98xy5juvh58h	2024-07-24 16:00:00	7b3edc	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwua00e298xyumd2vknn	2024-07-25 16:00:00	e9cb75	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwuf00e798xyly4f3kbd	2024-07-28 16:00:00	1a6f0a	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwui00ea98xyz69blgro	2024-07-29 16:00:00	48206d	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwum00ed98xyx2t15mcc	2024-07-30 16:00:00	c171df	clropuwsm00c998xyikjya8vx	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwup00eg98xyd1v6v6dy	2024-07-31 16:00:00	5e9426	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwur00ej98xy6m0si89q	2024-08-01 16:00:00	0c898f	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwuw00eo98xyn62mhw62	2024-08-04 16:00:00	9da143	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwuy00er98xyw07ntioj	2024-08-05 16:00:00	ea8526	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwv000eu98xyf6ft2531	2024-08-06 16:00:00	b60fdb	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwv300ex98xy4s1u98m4	2024-08-07 16:00:00	a6c161	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwv500f098xy22m2id56	2024-08-08 16:00:00	47f872	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwva00f598xyv3x8lyyo	2024-08-11 16:00:00	1b069d	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvd00f898xy5l6n8bhp	2024-08-12 16:00:00	19c072	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvh00fb98xyh6e58fk7	2024-08-13 16:00:00	ea17c2	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvk00fe98xy1vua059r	2024-08-14 16:00:00	4fd4e4	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvo00fh98xyf16dz62j	2024-08-15 16:00:00	e34351	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvt00fm98xy3kwjidl6	2024-08-18 16:00:00	9264f5	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwvv00fp98xy1yyrfleu	2024-08-19 16:00:00	768669	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuww100fv98xynzv7mdcr	2024-08-21 16:00:00	70bd1c	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuww400fy98xyzk7z8i6z	2024-08-22 16:00:00	ade0d0	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuww900g398xypb0b3l9k	2024-08-25 16:00:00	aa708e	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwb00g698xy2lg98nmo	2024-08-26 16:00:00	cfb6cc	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwk00g998xyw5lsfwda	2024-08-27 16:00:00	47266e	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwm00gc98xypmeyxpu1	2024-08-28 16:00:00	a9cfb8	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwq00gf98xyf03kjblw	2024-08-29 16:00:00	8f0ac2	clropuwun00ee98xyleegzy9j	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwy00gk98xysca8iu4e	2024-09-01 16:00:00	e55e7d	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwx100gn98xy4en4vxy8	2024-09-02 16:00:00	0ba97c	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwx300gq98xymn6lhwua	2024-09-03 16:00:00	81cae0	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwx600gt98xytsidgujh	2024-09-04 16:00:00	8dd913	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwx800gw98xyj3trdkwj	2024-09-05 16:00:00	afc025	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxe00h198xy0vybxvg1	2024-09-08 16:00:00	1044a2	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxg00h498xyh6euu8go	2024-09-09 16:00:00	891bb6	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxi00h798xy6tr7ngy7	2024-09-10 16:00:00	6c765b	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxk00ha98xy3s55ciqq	2024-09-11 16:00:00	acaa04	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxm00hd98xyjz8mcdrb	2024-09-12 16:00:00	25d8cb	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxs00hi98xyw3q230c5	2024-09-15 16:00:00	71980c	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxu00hl98xyt7kblkqt	2024-09-16 16:00:00	246ed5	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxw00ho98xye40w4r22	2024-09-17 16:00:00	9eeb88	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwxy00hr98xys115e2ev	2024-09-18 16:00:00	ab8c94	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwy000hu98xy5o2nt5d2	2024-09-19 16:00:00	a6167d	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwy600hz98xydi9nu3kw	2024-09-22 16:00:00	ba021d	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwy800i298xyufxdfa1k	2024-09-23 16:00:00	064aeb	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyb00i598xyfbu9lasv	2024-09-24 16:00:00	7312ae	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyd00i898xy8b73bbma	2024-09-25 16:00:00	006719	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyf00ib98xywbvmlp0k	2024-09-26 16:00:00	8a32bd	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyl00ig98xyeb1ihmk0	2024-09-29 16:00:00	01605c	clropuwwv00gh98xyvvzlzjpi	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyn00ij98xyo0xuon61	2024-09-30 16:00:00	420665	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyq00im98xykwz24tf1	2024-10-01 16:00:00	3d5d38	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwys00ip98xyimr4hj4v	2024-10-02 16:00:00	9d2b3a	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwyv00is98xyd5rufzjk	2024-10-03 16:00:00	2c1aac	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwz100ix98xyxpo7lwfl	2024-10-06 16:00:00	52fff4	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwz400j098xygtkei6wg	2024-10-07 16:00:00	713427	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwz700j398xy23pvyv85	2024-10-08 16:00:00	d8e963	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwz900j698xyrrsfpjj0	2024-10-09 16:00:00	32cf12	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzb00j998xyoe12k035	2024-10-10 16:00:00	d32afc	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzg00je98xyobsrxzbi	2024-10-13 16:00:00	8ffa63	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzj00jh98xydyqk9xh4	2024-10-14 16:00:00	463993	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzl00jk98xymo5w25jc	2024-10-15 16:00:00	cc4c5b	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzn00jn98xyzdnmyoc1	2024-10-16 16:00:00	7f817f	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzq00jq98xy76aam9kw	2024-10-17 16:00:00	d4f311	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzv00jv98xylx6g95v3	2024-10-20 16:00:00	3f4c23	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwzx00jy98xy31r2life	2024-10-21 16:00:00	cffb9d	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0000k198xyf63u7fqt	2024-10-22 16:00:00	6bb3cd	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0200k498xy9q5u95i8	2024-10-23 16:00:00	124412	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0600k798xy9ha07sf1	2024-10-24 16:00:00	c9b447	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0b00kc98xybpk97rjm	2024-10-27 16:00:00	eacee5	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0d00kf98xykk7eqz8t	2024-10-28 16:00:00	d0d173	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0f00ki98xy2lu41to0	2024-10-29 16:00:00	2015d2	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0i00kl98xyzczvsjui	2024-10-30 16:00:00	6b1821	clropuwym00ih98xykcdsfha3	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0p00kt98xyq03iryq0	2024-11-03 16:00:00	43a34c	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0r00kw98xyy9z77uyz	2024-11-04 16:00:00	df17b3	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0t00kz98xy5jvyicvz	2024-11-05 16:00:00	a4be82	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0v00l298xyxn6qle7m	2024-11-06 16:00:00	d41775	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0x00l598xy5hh0pj1u	2024-11-07 16:00:00	7a04cd	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1300la98xyltx84oyo	2024-11-10 16:00:00	e54a76	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1500ld98xyulc1qclh	2024-11-11 16:00:00	622b79	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1700lg98xyu0srgkzu	2024-11-12 16:00:00	e70105	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1900lj98xyeuld28xu	2024-11-13 16:00:00	d3e48f	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1b00lm98xy8ylikutk	2024-11-14 16:00:00	9e13af	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1h00lr98xypqf58wrh	2024-11-17 16:00:00	3d90e4	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1k00lu98xy3e1azdw9	2024-11-18 16:00:00	068b79	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1n00lx98xy1i7exfqy	2024-11-19 16:00:00	c6d3d0	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1p00m098xyaz6rw480	2024-11-20 16:00:00	394812	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1r00m398xy6fxll2mn	2024-11-21 16:00:00	f73097	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux1x00m898xyeb65o59h	2024-11-24 16:00:00	73133f	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2000mb98xy8yfmk7p7	2024-11-25 16:00:00	c6d7a1	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2200me98xy2x6i1n67	2024-11-26 16:00:00	4b1e08	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2400mh98xyvoal1skx	2024-11-27 16:00:00	860447	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2700mk98xya8xcphpc	2024-11-28 16:00:00	98e96e	clropux0j00km98xyix51mhx2	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2c00mp98xycvvff9rs	2024-12-01 16:00:00	a9515d	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2f00ms98xyqejm3r51	2024-12-02 16:00:00	ca5ffc	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2h00mv98xyea0qiqc2	2024-12-03 16:00:00	c34b6d	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2j00my98xyaxtj7d9i	2024-12-04 16:00:00	613853	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2l00n198xyeg9c5gzy	2024-12-05 16:00:00	067ea9	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2q00n698xye4kioujd	2024-12-08 16:00:00	3b512e	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2s00n998xylpp9xdaf	2024-12-09 16:00:00	ea5e84	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2v00nc98xyhbqp5qqs	2024-12-10 16:00:00	24e1df	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2y00nf98xyjgqtmznw	2024-12-11 16:00:00	a27ad0	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3000ni98xyyv54in52	2024-12-12 16:00:00	8b4e8e	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3500nn98xydgxnlbwb	2024-12-15 16:00:00	72c442	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3l00nq98xylefxfzfp	2024-12-16 16:00:00	fc0fcf	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3p00nt98xyw8hd3bs6	2024-12-17 16:00:00	385b25	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3t00nw98xy880vhp8m	2024-12-18 16:00:00	94bcc5	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux3w00nz98xyw8eetb6g	2024-12-19 16:00:00	95f93b	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4300o798xyzm7z1v2z	2024-12-23 16:00:00	ec7121	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4900od98xys4jihiwn	2024-12-25 16:00:00	fd20ee	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux4c00og98xyl4414sz1	2024-12-26 16:00:00	b81b42	clropux2900mm98xycdx1igtp	t	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
\.


--
-- Data for Name: WorkingMonth; Type: TABLE DATA; Schema: public?; Owner: -
--

COPY "public?"."WorkingMonth" ("id", "month", "year", "createdAt", "updatedAt") FROM stdin;
clropuwg8001e98xy3qyr8y2d	1	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwhm002498xys9ajiscx	2	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwk2004398xy2ee5dr5u	3	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwm9006498xyco1dezvd	4	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwod008698xygyfjf40g	5	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwqh00ab98xyntle801c	6	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwsm00c998xyikjya8vx	7	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwun00ee98xyleegzy9j	8	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwwv00gh98xyvvzlzjpi	9	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropuwym00ih98xykcdsfha3	10	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux0j00km98xyix51mhx2	11	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
clropux2900mm98xycdx1igtp	12	2024	2024-01-22 09:19:49.446	2024-01-22 09:19:49.446
\.


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("id");


--
-- Name: AdditionalEarnings AdditionalEarnings_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdditionalEarnings"
    ADD CONSTRAINT "AdditionalEarnings_pkey" PRIMARY KEY ("id");


--
-- Name: AddressLine AddressLine_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AddressLine"
    ADD CONSTRAINT "AddressLine_pkey" PRIMARY KEY ("id");


--
-- Name: AdvanceTimesheetUsers AdvanceTimesheetUsers_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdvanceTimesheetUsers"
    ADD CONSTRAINT "AdvanceTimesheetUsers_pkey" PRIMARY KEY ("userId", "advanceTimesheetId");


--
-- Name: AdvanceTimesheet AdvanceTimesheet_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdvanceTimesheet"
    ADD CONSTRAINT "AdvanceTimesheet_pkey" PRIMARY KEY ("id");


--
-- Name: Allowance Allowance_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Allowance"
    ADD CONSTRAINT "Allowance_pkey" PRIMARY KEY ("id");


--
-- Name: Archive Archive_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Archive"
    ADD CONSTRAINT "Archive_pkey" PRIMARY KEY ("id");


--
-- Name: AssignDesignation AssignDesignation_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AssignDesignation"
    ADD CONSTRAINT "AssignDesignation_pkey" PRIMARY KEY ("id");


--
-- Name: AuditLog AuditLog_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AuditLog"
    ADD CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id");


--
-- Name: DaysNotWorked DaysNotWorked_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DaysNotWorked"
    ADD CONSTRAINT "DaysNotWorked_pkey" PRIMARY KEY ("id");


--
-- Name: Deductions Deductions_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Deductions"
    ADD CONSTRAINT "Deductions_pkey" PRIMARY KEY ("id");


--
-- Name: DepartmentSalaryIncrease DepartmentSalaryIncrease_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DepartmentSalaryIncrease"
    ADD CONSTRAINT "DepartmentSalaryIncrease_pkey" PRIMARY KEY ("departmentId", "salaryIncreaseEventId");


--
-- Name: Department Department_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Department"
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY ("id");


--
-- Name: DesignationSalaryIncrease DesignationSalaryIncrease_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DesignationSalaryIncrease"
    ADD CONSTRAINT "DesignationSalaryIncrease_pkey" PRIMARY KEY ("designationId", "salaryIncreaseEventId");


--
-- Name: Designation Designation_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Designation"
    ADD CONSTRAINT "Designation_pkey" PRIMARY KEY ("id");


--
-- Name: Documents Documents_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Documents"
    ADD CONSTRAINT "Documents_pkey" PRIMARY KEY ("id");


--
-- Name: EmergencyContact EmergencyContact_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."EmergencyContact"
    ADD CONSTRAINT "EmergencyContact_pkey" PRIMARY KEY ("id");


--
-- Name: GovernmentContribution GovernmentContribution_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."GovernmentContribution"
    ADD CONSTRAINT "GovernmentContribution_pkey" PRIMARY KEY ("id");


--
-- Name: GovernmentId GovernmentId_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."GovernmentId"
    ADD CONSTRAINT "GovernmentId_pkey" PRIMARY KEY ("id");


--
-- Name: Holiday Holiday_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Holiday"
    ADD CONSTRAINT "Holiday_pkey" PRIMARY KEY ("id");


--
-- Name: Leaves Leaves_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Leaves"
    ADD CONSTRAINT "Leaves_pkey" PRIMARY KEY ("id");


--
-- Name: Overtimes Overtimes_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Overtimes"
    ADD CONSTRAINT "Overtimes_pkey" PRIMARY KEY ("id");


--
-- Name: PasswordResetToken PasswordResetToken_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."PasswordResetToken"
    ADD CONSTRAINT "PasswordResetToken_pkey" PRIMARY KEY ("id");


--
-- Name: PayrollItem PayrollItem_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."PayrollItem"
    ADD CONSTRAINT "PayrollItem_pkey" PRIMARY KEY ("id");


--
-- Name: Payroll Payroll_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Payroll"
    ADD CONSTRAINT "Payroll_pkey" PRIMARY KEY ("id");


--
-- Name: SalaryHistory SalaryHistory_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."SalaryHistory"
    ADD CONSTRAINT "SalaryHistory_pkey" PRIMARY KEY ("id");


--
-- Name: SalaryIncreaseEvent SalaryIncreaseEvent_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."SalaryIncreaseEvent"
    ADD CONSTRAINT "SalaryIncreaseEvent_pkey" PRIMARY KEY ("id");


--
-- Name: Timesheet Timesheet_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Timesheet"
    ADD CONSTRAINT "Timesheet_pkey" PRIMARY KEY ("id");


--
-- Name: TwoFactorConfirmation TwoFactorConfirmation_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."TwoFactorConfirmation"
    ADD CONSTRAINT "TwoFactorConfirmation_pkey" PRIMARY KEY ("id");


--
-- Name: TwoFactorToken TwoFactorToken_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."TwoFactorToken"
    ADD CONSTRAINT "TwoFactorToken_pkey" PRIMARY KEY ("id");


--
-- Name: UserSalary UserSalary_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."UserSalary"
    ADD CONSTRAINT "UserSalary_pkey" PRIMARY KEY ("id");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");


--
-- Name: VerificationToken VerificationToken_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."VerificationToken"
    ADD CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("id");


--
-- Name: WorkingDay WorkingDay_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."WorkingDay"
    ADD CONSTRAINT "WorkingDay_pkey" PRIMARY KEY ("id");


--
-- Name: WorkingMonth WorkingMonth_pkey; Type: CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."WorkingMonth"
    ADD CONSTRAINT "WorkingMonth_pkey" PRIMARY KEY ("id");


--
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "public?"."Account" USING "btree" ("provider", "providerAccountId");


--
-- Name: AddressLine_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "AddressLine_userId_key" ON "public?"."AddressLine" USING "btree" ("userId");


--
-- Name: Archive_archiveType_entityId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Archive_archiveType_entityId_key" ON "public?"."Archive" USING "btree" ("archiveType", "entityId");


--
-- Name: AssignDesignation_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "AssignDesignation_userId_key" ON "public?"."AssignDesignation" USING "btree" ("userId");


--
-- Name: Department_departmentHeadUserId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Department_departmentHeadUserId_key" ON "public?"."Department" USING "btree" ("departmentHeadUserId");


--
-- Name: Designation_designationHeadUserId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Designation_designationHeadUserId_key" ON "public?"."Designation" USING "btree" ("designationHeadUserId");


--
-- Name: EmergencyContact_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "EmergencyContact_userId_key" ON "public?"."EmergencyContact" USING "btree" ("userId");


--
-- Name: GovernmentContribution_type_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "GovernmentContribution_type_key" ON "public?"."GovernmentContribution" USING "btree" ("type");


--
-- Name: GovernmentId_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "GovernmentId_userId_key" ON "public?"."GovernmentId" USING "btree" ("userId");


--
-- Name: Holiday_date_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Holiday_date_key" ON "public?"."Holiday" USING "btree" ("date");


--
-- Name: Leaves_userId_startDate_endDate_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Leaves_userId_startDate_endDate_key" ON "public?"."Leaves" USING "btree" ("userId", "startDate", "endDate");


--
-- Name: Overtimes_userId_createdAt_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Overtimes_userId_createdAt_key" ON "public?"."Overtimes" USING "btree" ("userId", "createdAt");


--
-- Name: PasswordResetToken_email_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "PasswordResetToken_email_token_key" ON "public?"."PasswordResetToken" USING "btree" ("email", "token");


--
-- Name: PasswordResetToken_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "PasswordResetToken_token_key" ON "public?"."PasswordResetToken" USING "btree" ("token");


--
-- Name: PayrollItem_payrollId_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "PayrollItem_payrollId_userId_key" ON "public?"."PayrollItem" USING "btree" ("payrollId", "userId");


--
-- Name: Payroll_payPeriodStart_payPeriodEnd_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Payroll_payPeriodStart_payPeriodEnd_key" ON "public?"."Payroll" USING "btree" ("payPeriodStart", "payPeriodEnd");


--
-- Name: Timesheet_userId_dayId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "Timesheet_userId_dayId_key" ON "public?"."Timesheet" USING "btree" ("userId", "dayId");


--
-- Name: TwoFactorConfirmation_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "TwoFactorConfirmation_userId_key" ON "public?"."TwoFactorConfirmation" USING "btree" ("userId");


--
-- Name: TwoFactorToken_email_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "TwoFactorToken_email_token_key" ON "public?"."TwoFactorToken" USING "btree" ("email", "token");


--
-- Name: TwoFactorToken_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "TwoFactorToken_token_key" ON "public?"."TwoFactorToken" USING "btree" ("token");


--
-- Name: UserSalary_userId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "UserSalary_userId_key" ON "public?"."UserSalary" USING "btree" ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON "public?"."User" USING "btree" ("email");


--
-- Name: VerificationToken_email_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "VerificationToken_email_token_key" ON "public?"."VerificationToken" USING "btree" ("email", "token");


--
-- Name: VerificationToken_token_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "VerificationToken_token_key" ON "public?"."VerificationToken" USING "btree" ("token");


--
-- Name: WorkingDay_date_monthId_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "WorkingDay_date_monthId_key" ON "public?"."WorkingDay" USING "btree" ("date", "monthId");


--
-- Name: WorkingMonth_month_year_key; Type: INDEX; Schema: public?; Owner: -
--

CREATE UNIQUE INDEX "WorkingMonth_month_year_key" ON "public?"."WorkingMonth" USING "btree" ("month", "year");


--
-- Name: Account Account_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Account"
    ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AdditionalEarnings AdditionalEarnings_payrollItemId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdditionalEarnings"
    ADD CONSTRAINT "AdditionalEarnings_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "public?"."PayrollItem"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AdditionalEarnings AdditionalEarnings_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdditionalEarnings"
    ADD CONSTRAINT "AdditionalEarnings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AddressLine AddressLine_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AddressLine"
    ADD CONSTRAINT "AddressLine_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AdvanceTimesheetUsers AdvanceTimesheetUsers_advanceTimesheetId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdvanceTimesheetUsers"
    ADD CONSTRAINT "AdvanceTimesheetUsers_advanceTimesheetId_fkey" FOREIGN KEY ("advanceTimesheetId") REFERENCES "public?"."AdvanceTimesheet"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AdvanceTimesheetUsers AdvanceTimesheetUsers_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AdvanceTimesheetUsers"
    ADD CONSTRAINT "AdvanceTimesheetUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Allowance Allowance_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Allowance"
    ADD CONSTRAINT "Allowance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssignDesignation AssignDesignation_designationId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AssignDesignation"
    ADD CONSTRAINT "AssignDesignation_designationId_fkey" FOREIGN KEY ("designationId") REFERENCES "public?"."Designation"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssignDesignation AssignDesignation_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AssignDesignation"
    ADD CONSTRAINT "AssignDesignation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditLog AuditLog_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."AuditLog"
    ADD CONSTRAINT "AuditLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DaysNotWorked DaysNotWorked_payrollItemId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DaysNotWorked"
    ADD CONSTRAINT "DaysNotWorked_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "public?"."PayrollItem"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DaysNotWorked DaysNotWorked_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DaysNotWorked"
    ADD CONSTRAINT "DaysNotWorked_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deductions Deductions_payrollItemId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Deductions"
    ADD CONSTRAINT "Deductions_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "public?"."PayrollItem"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Deductions Deductions_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Deductions"
    ADD CONSTRAINT "Deductions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DepartmentSalaryIncrease DepartmentSalaryIncrease_departmentId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DepartmentSalaryIncrease"
    ADD CONSTRAINT "DepartmentSalaryIncrease_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "public?"."Department"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DepartmentSalaryIncrease DepartmentSalaryIncrease_salaryIncreaseEventId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DepartmentSalaryIncrease"
    ADD CONSTRAINT "DepartmentSalaryIncrease_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "public?"."SalaryIncreaseEvent"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Department Department_departmentHeadUserId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Department"
    ADD CONSTRAINT "Department_departmentHeadUserId_fkey" FOREIGN KEY ("departmentHeadUserId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DesignationSalaryIncrease DesignationSalaryIncrease_designationId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DesignationSalaryIncrease"
    ADD CONSTRAINT "DesignationSalaryIncrease_designationId_fkey" FOREIGN KEY ("designationId") REFERENCES "public?"."Designation"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DesignationSalaryIncrease DesignationSalaryIncrease_salaryIncreaseEventId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."DesignationSalaryIncrease"
    ADD CONSTRAINT "DesignationSalaryIncrease_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "public?"."SalaryIncreaseEvent"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Designation Designation_departmentId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Designation"
    ADD CONSTRAINT "Designation_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "public?"."Department"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Designation Designation_designationHeadUserId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Designation"
    ADD CONSTRAINT "Designation_designationHeadUserId_fkey" FOREIGN KEY ("designationHeadUserId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Documents Documents_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Documents"
    ADD CONSTRAINT "Documents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EmergencyContact EmergencyContact_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."EmergencyContact"
    ADD CONSTRAINT "EmergencyContact_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GovernmentId GovernmentId_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."GovernmentId"
    ADD CONSTRAINT "GovernmentId_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Leaves Leaves_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Leaves"
    ADD CONSTRAINT "Leaves_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Overtimes Overtimes_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Overtimes"
    ADD CONSTRAINT "Overtimes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PayrollItem PayrollItem_payrollId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."PayrollItem"
    ADD CONSTRAINT "PayrollItem_payrollId_fkey" FOREIGN KEY ("payrollId") REFERENCES "public?"."Payroll"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PayrollItem PayrollItem_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."PayrollItem"
    ADD CONSTRAINT "PayrollItem_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SalaryHistory SalaryHistory_salaryIncreaseEventId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."SalaryHistory"
    ADD CONSTRAINT "SalaryHistory_salaryIncreaseEventId_fkey" FOREIGN KEY ("salaryIncreaseEventId") REFERENCES "public?"."SalaryIncreaseEvent"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SalaryHistory SalaryHistory_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."SalaryHistory"
    ADD CONSTRAINT "SalaryHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Timesheet Timesheet_dayId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Timesheet"
    ADD CONSTRAINT "Timesheet_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES "public?"."WorkingDay"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Timesheet Timesheet_payrollItemId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Timesheet"
    ADD CONSTRAINT "Timesheet_payrollItemId_fkey" FOREIGN KEY ("payrollItemId") REFERENCES "public?"."PayrollItem"("id") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Timesheet Timesheet_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."Timesheet"
    ADD CONSTRAINT "Timesheet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TwoFactorConfirmation TwoFactorConfirmation_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."TwoFactorConfirmation"
    ADD CONSTRAINT "TwoFactorConfirmation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSalary UserSalary_userId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."UserSalary"
    ADD CONSTRAINT "UserSalary_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public?"."User"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WorkingDay WorkingDay_monthId_fkey; Type: FK CONSTRAINT; Schema: public?; Owner: -
--

ALTER TABLE ONLY "public?"."WorkingDay"
    ADD CONSTRAINT "WorkingDay_monthId_fkey" FOREIGN KEY ("monthId") REFERENCES "public?"."WorkingMonth"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

