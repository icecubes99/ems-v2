import { EmployeeType, Status, Gender, Prisma, LeaveStatus, LeaveType } from "@prisma/client"

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