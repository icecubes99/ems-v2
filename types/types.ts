import { EmployeeType, Status, Gender, Prisma, LeaveStatus, LeaveType, OvertimeType, Payroll, PayrollItem, } from "@prisma/client"
import { User as PrismaUser } from "@prisma/client"
export type AssignDesignation = {
    id: string
    employeeType: EmployeeType
    status: Status
    designationId: string
    userId: string
    createdAt: Date
    updatedAt: Date
}

export type User = {
    id: string
    firstName: string | null
    middleName: string | null
    lastName: string | null
    gender: Gender | null
    dateOfBirth: Date | null
    jobTitle: string | null
    email: string | null
    createdAt: Date | null
    updatedAt: Date | null
    lastLogin: Date | null
}

// Combined type
// export type AssignDesignationWithUser = Prisma.AssignDesignationGetPayload<{
//     include: { user: true }
// }>;

export type AssignDesignationWithUser = {
    id: string;
    employeeType: EmployeeType;
    status: Status;
    designationId: string;
    userId: string;
    createdAt: Date;
    updatedAt: Date;
    user: {
        id: string;
        firstName: string | null;
        middleName: string | null;
        lastName: string | null;
        gender: Gender | null;
        dateOfBirth: Date | null;
        jobTitle: string | null;
        email: string | null;
        createdAt: Date | null;
        updatedAt: Date | null;
        lastLogin: Date | null;
    };
};

export type LeavesWithUser = {
    id: string
    userId: string
    startDate: Date
    endDate: Date
    leaveStatus: LeaveStatus
    reason: string
    leaveType: LeaveType;
    user: {
        id: string;
        firstName: string | null;
        middleName: string | null;
        lastName: string | null;
        gender: Gender | null;
        dateOfBirth: Date | null;
        jobTitle: string | null;
        email: string | null;
        createdAt: Date | null;
        updatedAt: Date | null;
        lastLogin: Date | null;
    }
}

export type OvertimesWithUser = {
    id: string
    reason: string
    status: LeaveStatus
    overtimeType: OvertimeType
    createdAt: Date
    userId: string
    // user: {
    //     id: string;
    //     firstName: string | null;
    //     middleName: string | null;
    //     lastName: string | null;
    //     gender: Gender | null;
    //     dateOfBirth: Date | null;
    //     jobTitle: string | null;
    //     email: string | null;
    //     createdAt: Date | null;
    //     updatedAt: Date | null;
    //     lastLogin: Date | null;
    // }
    user: PrismaUser
}

export type DeductionsWithUser = {
    id: string;
    userId: string;
    deductionType: string;
    amount: number;
    description: string;
    payrollItemId?: string | null;
    createdAt: Date;
    updatedAt: Date;
    user: PrismaUser;

    // payrollItem: PayrollItem;
}

export type AdditionalEarningsWithUser = {
    id: string;
    userId: string;
    earningType: string;
    amount: number;
    description: string;
    payrollItemId?: string | null;
    createdAt: Date;
    updatedAt: Date;
    user: PrismaUser;

    // payrollItem: PayrollItem;
}


export type PayrollItemWithUser = {
    id: string;
    payrollId: string;
    payroll: Payroll;
    userId: string;
    user: PrismaUser;
    basicSalary: number;
    overtimeSalary: number;
    dailyRate: number;
    additionalEarnings: number;
    lateDeductions: number;
    earlyClockOutDeductions: number;
    totalDeductions: number;
    netSalary: number;
    daysWorked: number;
    daysNotWorked: number;
    minutesWorked: number;
    minutesNotWorked: number;
    minutesEarlyOut: number;
    minutesLate: number;
    minutesOvertime: number;
    createdAt: Date;
    updatedAt: Date;
    additionalEarningsArray: AdditionalEarnings[];
    deductions: Deductions[];
}

export type AdditionalEarnings = {
    id: string;
    userId: string;
    earningType: string;
    amount: number;
    description: string;
    payrollItemId: string | null;
    createdAt: Date;
    updatedAt: Date;
}

export type Deductions = {
    id: string;
    userId: string;
    deductionType: string;
    amount: number;
    description: string;
    payrollItemId: string | null;
    createdAt: Date;
    updatedAt: Date;
}

export type PayrollWithPayrollItems = {
    id: string;
    payPeriodStart: Date;
    payPeriodEnd: Date;
    payrollStatus: LeaveStatus;
    totalAmount: number;
    createdAt: Date;
    updatedAt: Date;

    payrollItems: PayrollItemWithUser[];
};